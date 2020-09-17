namespace JoyBrick.WAIO.Game.External
{
    using System.Collections;
    using System.Collections.Generic;
    using Mirror;
    using UniRx;
    using UniRx.Diagnostics;
    using UnityEngine;
    using UnityEngine.SceneManagement;

    public partial class Bootstrap :
        MonoBehavior
    {
        private static readonly UniRx.Diagnostics.Logger _logger = new UniRx.Diagnostics.Logger(nameof(Bootstrap));

        //
        private readonly CompositeDisposable _compositeDisposable = new CompositeDisposable();

        //
        void Awake()
        {
        }

        void Start()
        {
        }

        void OnDestroy()
        {
            _compositeDisposable?.Dispose();
        }
    }
}
