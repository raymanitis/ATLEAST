import{e2 as e,r as t,e3 as r,e4 as o}from"./vendor-4fd0b155.js";function s(e,t){for(var r=0;r<t.length;r++){const o=t[r];if("string"!=typeof o&&!Array.isArray(o))for(const t in o)if("default"!==t&&!(t in e)){const r=Object.getOwnPropertyDescriptor(o,t);r&&Object.defineProperty(e,t,r.get?r:{enumerable:!0,get:()=>o[t]})}}return Object.freeze(Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}))}var i=Object.create,n=Object.defineProperty,a=Object.getOwnPropertyDescriptor,l=Object.getOwnPropertyNames,u=Object.getPrototypeOf,p=Object.prototype.hasOwnProperty,d=(e,t,r,o)=>{if(t&&"object"==typeof t||"function"==typeof t)for(let s of l(t))p.call(e,s)||s===r||n(e,s,{get:()=>t[s],enumerable:!(o=a(t,s))||o.enumerable});return e},c=(e,t,r)=>(((e,t,r)=>{t in e?n(e,t,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[t]=r})(e,"symbol"!=typeof t?t+"":t,r),r),h={};((e,t)=>{for(var r in t)n(e,r,{get:t[r],enumerable:!0})})(h,{default:()=>g});var y,f=(y=h,d(n({},"__esModule",{value:!0}),y)),m=((e,t,r)=>(r=null!=e?i(u(e)):{},d(!t&&e&&e.__esModule?r:n(r,"default",{value:e,enumerable:!0}),e)))(t),b=r,P=o;class g extends m.Component{constructor(){super(...arguments),c(this,"callPlayer",b.callPlayer),c(this,"duration",null),c(this,"currentTime",null),c(this,"fractionLoaded",null),c(this,"mute",(()=>{this.setVolume(0)})),c(this,"unmute",(()=>{null!==this.props.volume&&this.setVolume(this.props.volume)})),c(this,"ref",(e=>{this.iframe=e}))}componentDidMount(){this.props.onMount&&this.props.onMount(this)}load(e,t){(0,b.getSDK)("https://w.soundcloud.com/player/api.js","SC").then((r=>{if(!this.iframe)return;const{PLAY:o,PLAY_PROGRESS:s,PAUSE:i,FINISH:n,ERROR:a}=r.Widget.Events;t||(this.player=r.Widget(this.iframe),this.player.bind(o,this.props.onPlay),this.player.bind(i,(()=>{this.duration-this.currentTime<.05||this.props.onPause()})),this.player.bind(s,(e=>{this.currentTime=e.currentPosition/1e3,this.fractionLoaded=e.loadedProgress})),this.player.bind(n,(()=>this.props.onEnded())),this.player.bind(a,(e=>this.props.onError(e)))),this.player.load(e,{...this.props.config.options,callback:()=>{this.player.getDuration((e=>{this.duration=e/1e3,this.props.onReady()}))}})}))}play(){this.callPlayer("play")}pause(){this.callPlayer("pause")}stop(){}seekTo(e,t=!0){this.callPlayer("seekTo",1e3*e),t||this.pause()}setVolume(e){this.callPlayer("setVolume",100*e)}getDuration(){return this.duration}getCurrentTime(){return this.currentTime}getSecondsLoaded(){return this.fractionLoaded*this.duration}render(){const{display:e}=this.props,t={width:"100%",height:"100%",display:e};return m.default.createElement("iframe",{ref:this.ref,src:`https://w.soundcloud.com/player/?url=${encodeURIComponent(this.props.url)}`,style:t,frameBorder:0,allow:"autoplay"})}}c(g,"displayName","SoundCloud"),c(g,"canPlay",P.canPlay.soundcloud),c(g,"loopOnEnded",!0);const O=s({__proto__:null,default:e(f)},[f]);export{O as S};
