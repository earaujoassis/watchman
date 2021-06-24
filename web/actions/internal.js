import * as actionTypes from './types';

export const internalSetConfigurationDisplayMode = (mode, hasErrors = false) => {
  return {
    type: actionTypes.INTERNAL_CONFIGURATION_DISPLAY_MODE,
    mode: {
      mode: mode,
      hasErrors: hasErrors
    }
  };
};

export const internalSetConfigurationDisplayModeError = (hasErrors = true) => {
  return {
    type: actionTypes.INTERNAL_CONFIGURATION_DISPLAY_MODE,
    mode: {
      hasErrors
    }
  };
};

export const internalSetModalDisplay = (displayModal = false) => {
  return {
    type: actionTypes.INTERNAL_DISPLAY_MODAL,
    displayModal
  };
};

export const internalSetToastDisplay = (displayToast = false) => {
  return {
    type: actionTypes.INTERNAL_DISPLAY_TOAST,
    displayToast
  };
};
