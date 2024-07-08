'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"flutter_bootstrap.js": "194a80afe621d20c4475367522986207",
"version.json": "1b865fb7c1fb40fb765c8848f76d4f3b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "4e3a387e4c767fb74ade9abb620b1c7a",
"assets/NOTICES": "298e5f367bc72ac10dc2926196a87ddf",
"assets/AssetManifest.bin": "b0a2fa673b1075e6fc33ee8b9fe17958",
"assets/assets/paint_particles_with_draw_rect.png": "1cb1d1f20e519e38353ff70a4659fac4",
"assets/assets/clip_with_save_layer.png": "a5f81dfa4ff9965554bad81cea3cea00",
"assets/assets/paint_mouth.png": "a40d4e83e114f31d7a4327692a84d5dd",
"assets/assets/clip_without_save_layer.png": "a8e99e0b11080fd9306e05110e23db2d",
"assets/assets/galaxy-brain-f-stage-5.png": "425b3a955b2a7e03922afe225457413c",
"assets/assets/vertex_vs_index.svg": "a4ae0997735bb06fc2e628b80b74b234",
"assets/assets/dashatars.png": "c6f56031c490a1840876cad1a99252e5",
"assets/assets/paint_andres-perez.jpg": "07cc9b382c3fe4692751f309bb950424",
"assets/assets/math.webp": "fe5902330427bde7a62dd1bcdbd4ede8",
"assets/assets/galaxy-brain-f-stage-3.png": "b356de653c49ac4f4873f81c9c307fdb",
"assets/assets/dailyn.webp": "1504fd708953d084e850a1d6bb996f71",
"assets/assets/opacity_without_save_layer.png": "50804e2ed2673e27b75faf395c6b7306",
"assets/assets/galaxy-brain-f-stage-2.png": "29fa9f5803226c1800000b2130fcf42f",
"assets/assets/paint_face.png": "860adccbb43571384fc5538b91ca4f08",
"assets/assets/what_gif.webp": "1f159e6760eb062d85f22bed4d9c70af",
"assets/assets/canvas_justyn-warner.jpg": "836f07662a0841cb89baf29b20d03a5c",
"assets/assets/whaaaat.webp": "9ff901168ce477abd5ab427e993221d8",
"assets/assets/opacity_with_save_layer.png": "179e0eb8208cc13552169c7c7332440d",
"assets/assets/speakers.png": "c662bdb242638ba54aa48053a75e5fbc",
"assets/assets/paint_eyes.png": "a7a07dce5c2fd84ca10abfa8caa19942",
"assets/assets/paint_moving_speakers.png": "9667f2f53fcc9a7f7748c55840dbb9cc",
"assets/assets/paint_moving_sparkles.png": "924316cacafcfcadaedbec770480d897",
"assets/assets/paint_sparkles.png": "0b1758735bb6d722f6ef774abdb2537c",
"assets/assets/dailyn_01.webp": "211714500bcea1e050234a71bb10c11a",
"assets/assets/galaxy-brain-f-stage-1.png": "daae970c4efc1854d6e80b39ee8edebe",
"assets/assets/paint_moving_eyes.png": "d4fa11b5394c4e2e7eb7ba85ef2a523f",
"assets/assets/paint_happy_sparles_opacity.png": "7900db521307853d6279d800143a2618",
"assets/assets/speaker.jpg": "2ddfa55a228c3140fd9f20cc04a338f9",
"assets/assets/logo_dailyn.svg": "aeb3f8a19b6c1c2ba4f3337fed47fce3",
"assets/assets/exported_qrcode_image_600.png": "cc4cac84c1ae2432fae748eaedb9fbef",
"assets/assets/methods_dillon-wanner.jpg": "48dd9780b41d367e4231b044fe9ddfba",
"assets/assets/paint_particles.png": "28cd04a79588d517c5b927050114354f",
"assets/shaders/oil_painting.frag": "5333d6b068df79fd3ecf4a009fe9a851",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/flutter_deck/assets/header.png": "7b35f3749eb44d6d99f8621da7ba71a5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/AssetManifest.bin.json": "b2c66e1b4ffbf974d05f7c1fc9e5c7c8",
"assets/FontManifest.json": "66544be9dda5807e6f5ed04dd0e14ef9",
"assets/fonts/PPNeueMontreal-Bold.otf": "7a5b9cad8ad4de4db25c26f390ca4ffc",
"assets/fonts/unb_pro_black.otf": "9e4df891d9afa4deca7ef5f3fa2b092f",
"assets/fonts/PPNeueMontreal-Medium.otf": "f366d0cc73854e67fc6790690668dcd2",
"assets/fonts/MaterialIcons-Regular.otf": "b4e32d0b285b753dfa3d20b2ff908ae4",
"assets/AssetManifest.json": "e42f14733051f92466ef609b888df411",
"index.html": "886699d2c5539fcacd6213b0a4eaa9a7",
"/": "886699d2c5539fcacd6213b0a4eaa9a7",
"manifest.json": "b9a301f2cc1851a9ce38c8419b575044"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
