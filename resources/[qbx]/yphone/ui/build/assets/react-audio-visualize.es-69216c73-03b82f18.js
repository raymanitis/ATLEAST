import{r as e,au as t}from"./vendor-4fd0b155.js";var r,n={exports:{}},a={};
/**
 * @license React
 * react-jsx-runtime.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */n.exports=function(){if(r)return a;r=1;var e=t,n=Symbol.for("react.element"),o=Symbol.for("react.fragment"),i=Object.prototype.hasOwnProperty,s=e.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner,l={key:!0,ref:!0,__self:!0,__source:!0};function c(e,t,r){var a,o={},c=null,u=null;for(a in void 0!==r&&(c=""+r),void 0!==t.key&&(c=""+t.key),void 0!==t.ref&&(u=t.ref),t)i.call(t,a)&&!l.hasOwnProperty(a)&&(o[a]=t[a]);if(e&&e.defaultProps)for(a in t=e.defaultProps)void 0===o[a]&&(o[a]=t[a]);return{$$typeof:n,type:e,key:c,ref:u,props:o,_owner:s.current}}return a.Fragment=o,a.jsx=c,a.jsxs=c,a}();var o=n.exports;const i=({mediaRecorder:t,width:r="100%",height:n="100%",barWidth:a=2,gap:i=1,backgroundColor:s="transparent",barColor:l="rgb(160, 198, 255)",fftSize:c=1024,maxDecibels:u=-10,minDecibels:f=-90,smoothingTimeConstant:h=.4})=>{const[d]=e.useState((()=>new AudioContext)),[m,g]=e.useState(),p=e.useRef(null);e.useEffect((()=>{if(!t.stream)return;const e=d.createAnalyser();g(e),e.fftSize=c,e.minDecibels=f,e.maxDecibels=u,e.smoothingTimeConstant=h,d.createMediaStreamSource(t.stream).connect(e)}),[t.stream]),e.useEffect((()=>{m&&"recording"===t.state&&y()}),[m,t.state]);const y=e.useCallback((()=>{if(!m)return;const e=new Uint8Array(null==m?void 0:m.frequencyBinCount);"recording"===t.state?(null==m||m.getByteFrequencyData(e),b(e),requestAnimationFrame(y)):"paused"===t.state?b(e):"inactive"===t.state&&"closed"!==d.state&&d.close()}),[m,d.state]),b=e=>{if(!p.current)return;const t=((e,t,r,n)=>{let a=t/(r+n),o=Math.floor(e.length/a);a>e.length&&(a=e.length,o=1);const i=[];for(let s=0;s<a;s++){let t=0;for(let r=0;r<o&&s*o+r<e.length;r++)t+=e[s*o+r];i.push(t/o)}return i})(e,p.current.width,a,i);((e,t,r,n,a,o)=>{const i=t.height/2,s=t.getContext("2d");s&&(s.clearRect(0,0,t.width,t.height),"transparent"!==a&&(s.fillStyle=a,s.fillRect(0,0,t.width,t.height)),e.forEach(((e,t)=>{s.fillStyle=o;const a=t*(r+n),l=i-e/2,c=r,u=e||1;s.beginPath(),s.roundRect?(s.roundRect(a,l,c,u,50),s.fill()):s.fillRect(a,l,c,u)})))})(t,p.current,a,i,s,l)};return o.jsx("canvas",{ref:p,width:r,height:n,style:{aspectRatio:"unset"}})},s=(e,t,r,n,a,o,i,s=0,l=1)=>{const c=t.height/2,u=t.getContext("2d");if(!u)return;u.clearRect(0,0,t.width,t.height),"transparent"!==a&&(u.fillStyle=a,u.fillRect(0,0,t.width,t.height));const f=(s||0)/l;e.forEach(((t,a)=>{const s=a/e.length,l=f>s;u.fillStyle=l&&i?i:o;const h=a*(r+n),d=c+t.min,m=r,g=c+t.max-d;u.beginPath(),u.roundRect?(u.roundRect(h,d,m,g,50),u.fill()):u.fillRect(h,d,m,g)}))},l=e.forwardRef((({blob:t,width:r,height:n,barWidth:a=2,gap:i=1,currentTime:l,style:c,backgroundColor:u="transparent",barColor:f="rgb(184, 184, 184)",barPlayedColor:h="rgb(160, 198, 255)"},d)=>{const m=e.useRef(null),[g,p]=e.useState([]),[y,b]=e.useState(0);return e.useImperativeHandle(d,(()=>m.current),[]),e.useEffect((()=>{(async()=>{if(!m.current)return;if(!t){const e=Array.from({length:100},(()=>({max:0,min:0})));return void s(e,m.current,a,i,u,f,h)}const e=await t.arrayBuffer();await(new AudioContext).decodeAudioData(e,(e=>{if(!m.current)return;b(e.duration);const t=((e,t,r,n,a)=>{const o=e.getChannelData(0),i=r/(n+a),s=Math.floor(o.length/i),l=t/2;let c=[],u=0;for(let f=0;f<i;f++){const t=[];let r=0;const n=[];let a=0;for(let c=0;c<s&&f*s+c<e.length;c++){const e=o[f*s+c];e<=0&&(t.push(e),r++),e>0&&(n.push(e),a++)}const i=t.reduce(((e,t)=>e+t),0)/r,l={max:n.reduce(((e,t)=>e+t),0)/a,min:i};l.max>u&&(u=l.max),Math.abs(l.min)>u&&(u=Math.abs(l.min)),c.push(l)}if(.8*l>u*l){const e=.8*l/u;c=c.map((t=>({max:t.max*e,min:t.min*e})))}return c})(e,n,r,a,i);p(t),s(t,m.current,a,i,u,f,h)}))})()}),[t,m.current]),e.useEffect((()=>{m.current&&s(g,m.current,a,i,u,f,h,l,y)}),[l,y]),o.jsx("canvas",{ref:m,width:r,height:n,style:{...c}})}));l.displayName="AudioVisualizer";export{l as AudioVisualizer,i as LiveAudioVisualizer};
