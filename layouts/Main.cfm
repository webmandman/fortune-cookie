<cfoutput>
<!DOCTYPE html>
<html lang="en" class="w-screen h-screen overflow-x-hidden">
<head>
	<meta charset="utf-8">
	<title>Welcome to Coldbox!</title>
	<meta name="description" content="ColdBox Application Template">
    <meta name="author" content="Ortus Solutions, Corp">
	<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
	<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
	<script>
		document.addEventListener('alpine:init', () => {
			Alpine.data('fortuneApp', () => ({
				fortune: {},
				
				init(){
					this.randomFortune();
				},

				async randomFortune( notId ){
					const url = notId ? `/fortune/random?notId=${notId}` : "/fortune/random"
					const response = await fetch( url );
					const data = await response.json();

					this.fortune = data.data[0];
				},

				async like( fortuneId ){
					const response = await fetch( `/fortune/${fortuneId}/up` );
					const data = await response.json();

					this.fortune = data.data;
				},

				async dislike( fortuneId ){
					const response = await fetch( `/fortune/${fortuneId}/down` );
					const data = await response.json();

					this.fortune = data.data;
				}
			}));
		});
	</script>
</head>
<body class="w-screen h-screen overflow-x-hidden flex flex-col items-center p-32">
	<div x-data="fortuneApp" class="flex flex-col text-xl items-center">
		<h1 class="mb-8">Fortune Cookie Teller App</h1>
		<div class="flex flex-col items-center gap-8">
			<div class="flex items-center jutify-center w-64 h-64">
				<p class="text-base w-64 text-center" x-text="fortune.fortune"></p>
			</div>
			<div class="flex gap-4">
				<div class="flex flex-col items-center">
					<button class="w-12 h-12 bg-green-300 text-2xl cursor-pointer" @click="like( fortune.id )"><i class="fa-solid fa-thumbs-up"></i></i></button>
					<span x-text="fortune.likeCount"></span>
				</div>
				<button class="h-12 bg-gray-300 text-2xl cursor-pointer px-2" @click="randomFortune( fortune.id )">New Fortune</button>
				<div class="flex flex-col items-center">
					<button class="w-12 h-12 bg-red-300 text-2xl cursor-pointer" @click="dislike( fortune.id )"><i class="fa-solid fa-thumbs-down fa-flip-horizontal"></i></button>
					<span x-text="fortune.dislikeCount"></span>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
</cfoutput>
