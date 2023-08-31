import React from 'react';

import Header from '@components/Header';
import Footer from '@components/Footer';

import './style.css';

const emptyCorpus = () => {
  return (
    <div role="main" className="empty-corpus-root">
      <div className="empty-corpus-root__corpus">
        <Header />
        <div className="empty-corpus-root__siblings">
          <div className="empty-corpus-root__corpus">
            <div className="empty-corpus-root__empty"></div>
            <Footer />
          </div>
        </div>
      </div>
    </div>
  );
};

export default emptyCorpus;
