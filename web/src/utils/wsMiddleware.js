const socketMiddleware = () => {
  const ws = new WebSocket(`ws://${window.document.location.host}/`);

  return ({ dispatch }) => next => (action) => {
    // Skip this middleware if action is a function (this means it's not a WebSocket message)
    if (typeof action === 'function') {
      return next(action);
    }

    const {
      event,
      unsubscribe,
      handle,
      ...rest
    } = action;

    if (!event) {
      return next(action);
    }

    if (unsubscribe) {
      ws.removeListener(event);
    }

    let handleEvent = handle;
    if (typeof handleEvent === 'string') {
      handleEvent = result => dispatch({ type: handle, result, ...rest });
    }

    return ws.addEventListener(event, ({ data }) => {
      let processedData;

      try {
        processedData = JSON.parse(data);
      } catch (error) {
        console.warn(`The following message was received but can't be used: ${data}`);
        processedData = {};
      }

      handleEvent(processedData);
    });
  };
};

export default socketMiddleware;