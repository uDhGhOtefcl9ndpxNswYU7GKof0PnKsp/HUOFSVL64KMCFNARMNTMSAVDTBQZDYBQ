#!/bin/bash
IFS=
git clone https://github.com/Psiphon-Labs/psiphon-tunnel-core.git
function index {
	for i in $( ls ) ; do
		[[ -d $i ]] && (
			cd $i
			index
		)
	done
	[[ -f ./index.htm ]] &&
		return
	printf '<HTML>
	<BODY>
		<H1>
			Index
		</H1>
		<HR/>
		<UL>
			<LI>
				<A HREF="/">
					/
				</A>
			</LI>
			<LI>
				<A HREF="..">
					..
				</A>
			</LI>
' >> index.htm
	for i in $( ls ) ; do
		printf "			<LI>
				<A HREF=\"./$i\">
					$i" >> index.htm
		[[ -d $i ]] &&
			printf "/" >> index.htm
		printf '
				</A>
			</LI>
' >> index.htm
	done
	printf '		</UL>
	</BODY>
</HTML>
' >> index.htm
	sed -i 's/$/^M/' index.htm
}
index
exit 0

