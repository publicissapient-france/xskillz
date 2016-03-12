import SigninGoogleButton from "./SigninGoogleButton";
import makeAsyncScriptLoader from "react-async-script";

const callbackName = "onloadcallback";
const URL = `https://apis.google.com/js/client.js?onload=${callbackName}&render=explicit`;
const globalName = "gapi";

export default makeAsyncScriptLoader(SigninGoogleButton, URL, {
    callbackName: callbackName,
    globalName: globalName
});