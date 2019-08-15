Received: from mx2.suse.de ([195.135.220.15]:45270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbfHOKWq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 15 Aug 2019 06:22:46 -0400
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] generic: Optimize generic/519
Date: Thu, 15 Aug 2019 13:22:40 +0300
Message-Id: <20190815102240.31110-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, sandeen@sandeen.net, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

Currently generic/519 takes around 5-10 minutes for me. This is mainly
due to the fact it uses a bunch of commands which spawn processes. This,
coupled by the fact the algorithm is O(n^2) in the number of lines (624)
for the sparse file and that test feels like it's hung.

Fix this by re-implementing the existing logic in awk. This causes a s
single processes to be spawned and the rest of the processing is done
in-memory. This makes the test complete in 2 seconds for me.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/generic/519 | 67 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/tests/generic/519 b/tests/generic/519
index d1a3c1711ec1..b7ef1d9c5008 100755
--- a/tests/generic/519
+++ b/tests/generic/519
@@ -42,8 +42,6 @@ testfile="$SCRATCH_MNT/$seq-testfile"
 # the FIEMAP ioctl. Then verify if there's map overlap.
 verify_filefrag()
 {
-	local n=1
-
 	# record details in .full file
 	${FILEFRAG_PROG} -Bes -v $testfile >> $seqres.full
 
@@ -52,36 +50,41 @@ verify_filefrag()
 	${FILEFRAG_PROG} -Be $testfile | _filter_filefrag | \
 		cut -d# -f1-2 > $tmp.filefrag
 
-	# Verify there's not physical address overlay
-	for i in `cat $tmp.filefrag`; do
-		# Get the start(v1) and end(v2) addresses will be verified
-		v1=`sed -n "${n}p" $tmp.filefrag | cut -d# -f1`
-		v2=`sed -n "${n}p" $tmp.filefrag | cut -d# -f2`
-		# The 2nd value is length, so the real end is:
-		v2=$((v1 + v2))
-
-		# Remove the line need to be verified ($i), compare with other
-		# lines one by one
-		sed -e "${n}d" $tmp.filefrag > $tmp.filefrag.tmp
-		for j in `cat $tmp.filefrag.tmp`; do
-			# Get 'next' line start(e1) and end(e2) addresses
-			e1=`echo $j | cut -d# -f1`
-			e2=`echo $j | cut -d# -f2`
-			# The 2nd value is length, so the real end is:
-			e2=$((e1 + e2))
-
-			# Verify there's not:
-			#       [ e1 ... e2 ]
-			#             [ v1 ... v2 ]
-			# Or:
-			#       [ e1 ... e2 ]
-			# [ v1 ... v2 ]
-			if ! [ ${v1} -ge ${e2} -o ${v2} -le ${e1} ]; then
-				echo "find physical addr overlap [$i] vs [$j]"
-			fi
-		done
-		((n++))
-	done
+	# Verify there's no physical address overlay
+	awk '
+		BEGIN {i=0}
+		{
+			# create a lines array of the form begin#end offsets
+			split($0,res,"#")
+			begin=res[1]
+			end=begin+res[2]
+			lines[i++]=begin"#"end
+		}
+		END {
+			for (i in lines) {
+				for (j in lines) {
+					# Dont check i-th line against itself
+					if (i == j)
+						continue
+
+					split(lines[i],i_line,"#")
+					split(lines[j],j_line,"#")
+					v1=i_line[1]
+					v2=i_line[2]
+					e1=j_line[1]
+					e2=j_line[2]
+					# Verify there is not:
+					#       [ e1 ... e2 ]
+					#             [ v1 ... v2 ]
+					# Or:
+					#       [ e1 ... e2 ]
+					# [ v1 ... v2 ]
+					if (! (v1 >= e2 || v2 <= e1))
+						print "find physical addr overlap " lines[i] " vs " lines[j]
+				}
+			}
+		}
+	' $tmp.filefrag
 }
 
 _scratch_mkfs > $seqres.full 2>&1
-- 
2.7.4
