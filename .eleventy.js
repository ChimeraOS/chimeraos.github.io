module.exports = function(config) {

	config.addPassthroughCopy({ 'src/_assets/': '/' });

	return {
		dir : {
			input  : 'src',
			output : 'docs'
		}
	}
};
