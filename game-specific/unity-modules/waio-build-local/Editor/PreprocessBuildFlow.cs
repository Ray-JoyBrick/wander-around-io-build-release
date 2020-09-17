namespace JoyBrick.WAIO.Build
{
    using System.IO;
    using UnityEditor;
    using UnityEditor.Build;
    using UnityEditor.Build.Reporting;
    using UnityEngine;

    //
    using GameCommon = JoyBrick.WAIO.Game.Common;
    using GameCommonEditor = JoyBrick.WAIO.Game.Common.EditorPart;

#if WAIO_FLOWCONTROL
    using GameFlowControlEditor = JoyBrick.WAIO.Game.FlowControl.EditorPart;
#endif

    class PreprocessBuildFlow : IPreprocessBuildWithReport
    {
        public int callbackOrder => 0;
        public void OnPreprocessBuild(BuildReport report)
        {
            Debug.Log($"PreprocessBuildFlow - OnPreprocessBuild - report: {report}");

#if COMPLETE_PROJECT

            // Setup app icon
            AppIconSetHelper.SetAndroidAdaptive();
            AppIconSetHelper.SetAndroidRound();
            AppIconSetHelper.SetAndroidLegacy();

#endif

            // Setup app settings
#if WAIO_FLOWCONTROL
            GameFlowControlEditor.CountHelper.CountAssetWaitAttribute();
            // GameFlowControlEditor.CountHelper.CountDoneLoadingAssetWaitAttribute();
            // GameFlowControlEditor.CountHelper.CountDoneSettingAssetWaitAttribute();
            // AssetDatabase.Refresh();
#endif
        }
    }
}
