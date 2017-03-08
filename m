Received: from mx1.redhat.com ([209.132.183.28]:40140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752239AbdCHRu4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 8 Mar 2017 12:50:56 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E41380F63
        for <fstests@vger.kernel.org>; Wed,  8 Mar 2017 17:43:07 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] fstests: add the missing _supported_fs to tests
Date: Thu,  9 Mar 2017 01:42:57 +0800
Message-Id: <20170308174257.11425-1-eguan@redhat.com>
In-Reply-To: <20170308115410.11346-1-eguan@redhat.com>
References: <20170308115410.11346-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

There're many tests that are missing _supported_fs check. I first
noticed this by running ext4/308 under an XFS test config by
accident then realized that there might be more tests missing
supported fs type check.

Note that ext4/307 has redundant _supported_fs line and xfs/040 is
missing both _supported_os and _supported_fs.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- go through and update all tests that are missing _supported_fs,
  not only ext4/308

 tests/ext4/307    | 1 -
 tests/ext4/308    | 1 +
 tests/generic/008 | 1 +
 tests/generic/009 | 1 +
 tests/generic/110 | 1 +
 tests/generic/111 | 1 +
 tests/generic/115 | 1 +
 tests/generic/116 | 1 +
 tests/generic/118 | 1 +
 tests/generic/119 | 1 +
 tests/generic/121 | 1 +
 tests/generic/122 | 1 +
 tests/generic/134 | 1 +
 tests/generic/136 | 1 +
 tests/generic/137 | 1 +
 tests/generic/138 | 1 +
 tests/generic/139 | 1 +
 tests/generic/140 | 1 +
 tests/generic/142 | 1 +
 tests/generic/143 | 1 +
 tests/generic/144 | 1 +
 tests/generic/145 | 1 +
 tests/generic/146 | 1 +
 tests/generic/147 | 1 +
 tests/generic/148 | 1 +
 tests/generic/149 | 1 +
 tests/generic/150 | 1 +
 tests/generic/151 | 1 +
 tests/generic/152 | 1 +
 tests/generic/153 | 1 +
 tests/generic/154 | 1 +
 tests/generic/155 | 1 +
 tests/generic/156 | 1 +
 tests/generic/157 | 1 +
 tests/generic/158 | 1 +
 tests/generic/159 | 1 +
 tests/generic/160 | 1 +
 tests/generic/161 | 1 +
 tests/generic/162 | 1 +
 tests/generic/163 | 1 +
 tests/generic/164 | 1 +
 tests/generic/165 | 1 +
 tests/generic/166 | 1 +
 tests/generic/167 | 1 +
 tests/generic/168 | 1 +
 tests/generic/170 | 1 +
 tests/generic/171 | 1 +
 tests/generic/172 | 1 +
 tests/generic/173 | 1 +
 tests/generic/174 | 1 +
 tests/generic/175 | 1 +
 tests/generic/176 | 1 +
 tests/generic/178 | 1 +
 tests/generic/179 | 1 +
 tests/generic/180 | 1 +
 tests/generic/181 | 1 +
 tests/generic/182 | 1 +
 tests/generic/183 | 1 +
 tests/generic/185 | 1 +
 tests/generic/186 | 1 +
 tests/generic/187 | 1 +
 tests/generic/188 | 1 +
 tests/generic/189 | 1 +
 tests/generic/190 | 1 +
 tests/generic/191 | 1 +
 tests/generic/194 | 1 +
 tests/generic/195 | 1 +
 tests/generic/196 | 1 +
 tests/generic/197 | 1 +
 tests/generic/199 | 1 +
 tests/generic/200 | 1 +
 tests/generic/201 | 1 +
 tests/generic/202 | 1 +
 tests/generic/203 | 1 +
 tests/generic/205 | 1 +
 tests/generic/206 | 1 +
 tests/generic/216 | 1 +
 tests/generic/217 | 1 +
 tests/generic/218 | 1 +
 tests/generic/220 | 1 +
 tests/generic/222 | 1 +
 tests/generic/227 | 1 +
 tests/generic/229 | 1 +
 tests/generic/238 | 1 +
 tests/generic/242 | 1 +
 tests/generic/243 | 1 +
 tests/generic/250 | 1 +
 tests/generic/252 | 1 +
 tests/generic/253 | 1 +
 tests/generic/254 | 1 +
 tests/generic/259 | 1 +
 tests/generic/261 | 1 +
 tests/generic/262 | 1 +
 tests/generic/264 | 1 +
 tests/generic/265 | 1 +
 tests/generic/266 | 1 +
 tests/generic/267 | 1 +
 tests/generic/268 | 1 +
 tests/generic/271 | 1 +
 tests/generic/272 | 1 +
 tests/generic/276 | 1 +
 tests/generic/278 | 1 +
 tests/generic/279 | 1 +
 tests/generic/281 | 1 +
 tests/generic/282 | 1 +
 tests/generic/283 | 1 +
 tests/generic/284 | 1 +
 tests/generic/287 | 1 +
 tests/generic/289 | 1 +
 tests/generic/290 | 1 +
 tests/generic/291 | 1 +
 tests/generic/292 | 1 +
 tests/generic/293 | 1 +
 tests/generic/295 | 1 +
 tests/generic/296 | 1 +
 tests/generic/297 | 1 +
 tests/generic/298 | 1 +
 tests/generic/301 | 1 +
 tests/generic/302 | 1 +
 tests/generic/303 | 1 +
 tests/generic/304 | 1 +
 tests/generic/305 | 1 +
 tests/generic/324 | 1 +
 tests/generic/326 | 1 +
 tests/generic/327 | 1 +
 tests/generic/328 | 1 +
 tests/generic/329 | 1 +
 tests/generic/330 | 1 +
 tests/generic/331 | 1 +
 tests/generic/332 | 1 +
 tests/generic/333 | 1 +
 tests/generic/334 | 1 +
 tests/generic/349 | 1 +
 tests/generic/350 | 1 +
 tests/generic/351 | 1 +
 tests/generic/356 | 1 +
 tests/generic/357 | 1 +
 tests/generic/358 | 1 +
 tests/generic/359 | 1 +
 tests/xfs/040     | 3 +++
 tests/xfs/076     | 1 +
 tests/xfs/132     | 1 +
 tests/xfs/139     | 1 +
 tests/xfs/140     | 1 +
 tests/xfs/215     | 1 +
 tests/xfs/218     | 1 +
 tests/xfs/219     | 1 +
 tests/xfs/221     | 1 +
 tests/xfs/223     | 1 +
 tests/xfs/224     | 1 +
 tests/xfs/225     | 1 +
 tests/xfs/226     | 1 +
 tests/xfs/228     | 1 +
 tests/xfs/230     | 1 +
 tests/xfs/248     | 1 +
 tests/xfs/249     | 1 +
 tests/xfs/251     | 1 +
 tests/xfs/254     | 1 +
 tests/xfs/255     | 1 +
 tests/xfs/256     | 1 +
 tests/xfs/257     | 1 +
 tests/xfs/258     | 1 +
 tests/xfs/269     | 1 +
 163 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/tests/ext4/307 b/tests/ext4/307
index 4bca056..c5b0aaa 100755
--- a/tests/ext4/307
+++ b/tests/ext4/307
@@ -58,7 +58,6 @@ _workout()
 }
 
 # real QA test starts here
-_supported_fs generic
 _supported_fs ext4
 _supported_os Linux
 _require_scratch
diff --git a/tests/ext4/308 b/tests/ext4/308
index 74bfc1b..4a811af 100755
--- a/tests/ext4/308
+++ b/tests/ext4/308
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs ext4
 _require_scratch
 _require_defrag
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/008 b/tests/generic/008
index 9b70b28..2e012d9 100755
--- a/tests/generic/008
+++ b/tests/generic/008
@@ -42,6 +42,7 @@ trap "exit \$status" 0 1 2 3 15
 
 # Modify as appropriate.
 _supported_os Linux
+_supported_fs generic
 
 _require_xfs_io_command "fzero"
 _require_test
diff --git a/tests/generic/009 b/tests/generic/009
index 5902afd..eacf3e8 100755
--- a/tests/generic/009
+++ b/tests/generic/009
@@ -44,6 +44,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_xfs_io_command "fzero"
 _require_xfs_io_command "fiemap"
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/110 b/tests/generic/110
index 1fcdb56..231b5e6 100755
--- a/tests/generic/110
+++ b/tests/generic/110
@@ -48,6 +48,7 @@ _cleanup()
 # real QA test starts here
 _require_test_reflink
 _supported_os Linux
+_supported_fs generic
 
 _require_xfs_io_command "fiemap"
 _require_cp_reflink
diff --git a/tests/generic/111 b/tests/generic/111
index dce9c84..7316a19 100755
--- a/tests/generic/111
+++ b/tests/generic/111
@@ -48,6 +48,7 @@ _cleanup()
 # real QA test starts here
 _require_test_reflink
 _supported_os Linux
+_supported_fs generic
 
 _require_xfs_io_command "fiemap"
 _require_cp_reflink
diff --git a/tests/generic/115 b/tests/generic/115
index 43ce59c..470d99f 100755
--- a/tests/generic/115
+++ b/tests/generic/115
@@ -46,6 +46,7 @@ _cleanup()
 # real QA test starts here
 _require_test_reflink
 _supported_os Linux
+_supported_fs generic
 
 _require_xfs_io_command "fiemap"
 _require_cp_reflink
diff --git a/tests/generic/116 b/tests/generic/116
index 620a358..5c0d02a 100755
--- a/tests/generic/116
+++ b/tests/generic/116
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 
 rm -f $seqres.full
diff --git a/tests/generic/118 b/tests/generic/118
index 66dbc04..9e02961 100755
--- a/tests/generic/118
+++ b/tests/generic/118
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 
 rm -f $seqres.full
diff --git a/tests/generic/119 b/tests/generic/119
index b28e044..83ca3c6 100755
--- a/tests/generic/119
+++ b/tests/generic/119
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_arbitrary_fileset_reflink
 
diff --git a/tests/generic/121 b/tests/generic/121
index d17f047..1157f5d 100755
--- a/tests/generic/121
+++ b/tests/generic/121
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_dedupe
 
 rm -f $seqres.full
diff --git a/tests/generic/122 b/tests/generic/122
index 5008190..7fc6859 100755
--- a/tests/generic/122
+++ b/tests/generic/122
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_dedupe
 
 rm -f $seqres.full
diff --git a/tests/generic/134 b/tests/generic/134
index 8dc9988..652a344 100755
--- a/tests/generic/134
+++ b/tests/generic/134
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 
 rm -f $seqres.full
diff --git a/tests/generic/136 b/tests/generic/136
index 665749f..3a4b494 100755
--- a/tests/generic/136
+++ b/tests/generic/136
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_dedupe
 
 rm -f $seqres.full
diff --git a/tests/generic/137 b/tests/generic/137
index a813036..05f2c38 100755
--- a/tests/generic/137
+++ b/tests/generic/137
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_test_dedupe
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/138 b/tests/generic/138
index f8a3197..2b27375 100755
--- a/tests/generic/138
+++ b/tests/generic/138
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/139 b/tests/generic/139
index ef66034..5f2ff39 100755
--- a/tests/generic/139
+++ b/tests/generic/139
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/140 b/tests/generic/140
index bf95ec1..281089b 100755
--- a/tests/generic/140
+++ b/tests/generic/140
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/142 b/tests/generic/142
index d19725f..cde4927 100755
--- a/tests/generic/142
+++ b/tests/generic/142
@@ -47,6 +47,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/143 b/tests/generic/143
index 8c4f9ce..d07a4fd 100755
--- a/tests/generic/143
+++ b/tests/generic/143
@@ -47,6 +47,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/144 b/tests/generic/144
index dbbe169..aaaefe7 100755
--- a/tests/generic/144
+++ b/tests/generic/144
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/145 b/tests/generic/145
index 93d3839..c539d27 100755
--- a/tests/generic/145
+++ b/tests/generic/145
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/146 b/tests/generic/146
index b1013f8..0de2156 100755
--- a/tests/generic/146
+++ b/tests/generic/146
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/147 b/tests/generic/147
index a1f59a0..0fe4d5d 100755
--- a/tests/generic/147
+++ b/tests/generic/147
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "finsert"
diff --git a/tests/generic/148 b/tests/generic/148
index 31e7ebe..efa9e92 100755
--- a/tests/generic/148
+++ b/tests/generic/148
@@ -47,6 +47,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "truncate"
diff --git a/tests/generic/149 b/tests/generic/149
index 0f13b79..092e634 100755
--- a/tests/generic/149
+++ b/tests/generic/149
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fzero"
diff --git a/tests/generic/150 b/tests/generic/150
index b57db51..7bdff59 100755
--- a/tests/generic/150
+++ b/tests/generic/150
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/151 b/tests/generic/151
index efb93ed..2732e00 100755
--- a/tests/generic/151
+++ b/tests/generic/151
@@ -49,6 +49,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/152 b/tests/generic/152
index ee009ea..e3173b5 100755
--- a/tests/generic/152
+++ b/tests/generic/152
@@ -49,6 +49,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/153 b/tests/generic/153
index fb5d552..f53fdd1 100755
--- a/tests/generic/153
+++ b/tests/generic/153
@@ -49,6 +49,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fcollapse"
diff --git a/tests/generic/154 b/tests/generic/154
index 9daee70..1bd5bfe 100755
--- a/tests/generic/154
+++ b/tests/generic/154
@@ -49,6 +49,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/155 b/tests/generic/155
index 9eead24..d95d330 100755
--- a/tests/generic/155
+++ b/tests/generic/155
@@ -52,6 +52,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fzero"
diff --git a/tests/generic/156 b/tests/generic/156
index a81b91a..eac8d55 100755
--- a/tests/generic/156
+++ b/tests/generic/156
@@ -56,6 +56,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "funshare"
diff --git a/tests/generic/157 b/tests/generic/157
index 722dc22..af65865 100755
--- a/tests/generic/157
+++ b/tests/generic/157
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_scratch_reflink
 
diff --git a/tests/generic/158 b/tests/generic/158
index c4f8bb8..6ef2a34 100755
--- a/tests/generic/158
+++ b/tests/generic/158
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_dedupe
 _require_scratch_dedupe
 
diff --git a/tests/generic/159 b/tests/generic/159
index 7e52d5c..dd6bb3a 100755
--- a/tests/generic/159
+++ b/tests/generic/159
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_lsattr
 _require_test_reflink
 
diff --git a/tests/generic/160 b/tests/generic/160
index 409b15e..137572a 100755
--- a/tests/generic/160
+++ b/tests/generic/160
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_lsattr
 _require_test_dedupe
 
diff --git a/tests/generic/161 b/tests/generic/161
index ba7108e..251beda 100755
--- a/tests/generic/161
+++ b/tests/generic/161
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/162 b/tests/generic/162
index 61cf463..82e1dd1 100755
--- a/tests/generic/162
+++ b/tests/generic/162
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_dedupe
 
 echo "Format and mount"
diff --git a/tests/generic/163 b/tests/generic/163
index e2c6042..492d3b0 100755
--- a/tests/generic/163
+++ b/tests/generic/163
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_dedupe
 
 echo "Format and mount"
diff --git a/tests/generic/164 b/tests/generic/164
index 78ea787..708fd50 100755
--- a/tests/generic/164
+++ b/tests/generic/164
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/165 b/tests/generic/165
index ca11e1e..96fc12b 100755
--- a/tests/generic/165
+++ b/tests/generic/165
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/166 b/tests/generic/166
index 8600a13..dfb1b34 100755
--- a/tests/generic/166
+++ b/tests/generic/166
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/167 b/tests/generic/167
index 261506b..642a351 100755
--- a/tests/generic/167
+++ b/tests/generic/167
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/168 b/tests/generic/168
index ceee264..7069dbf 100755
--- a/tests/generic/168
+++ b/tests/generic/168
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 
 echo "Format and mount"
diff --git a/tests/generic/170 b/tests/generic/170
index 6559243..1ff802f 100755
--- a/tests/generic/170
+++ b/tests/generic/170
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_odirect
 
diff --git a/tests/generic/171 b/tests/generic/171
index 0942ac3..880b640 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/172 b/tests/generic/172
index d8ab882..273e60d 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/173 b/tests/generic/173
index ad4e5da..f329fb4 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/174 b/tests/generic/174
index d230577..e208042 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/175 b/tests/generic/175
index df25f0a..837de8d 100755
--- a/tests/generic/175
+++ b/tests/generic/175
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/176 b/tests/generic/176
index 3e61b68..3e888d0 100755
--- a/tests/generic/176
+++ b/tests/generic/176
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_test_program "punch-alternating"
diff --git a/tests/generic/178 b/tests/generic/178
index 7540802..f1e8d9d 100755
--- a/tests/generic/178
+++ b/tests/generic/178
@@ -42,6 +42,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/179 b/tests/generic/179
index c0ea70f..95e2c75 100755
--- a/tests/generic/179
+++ b/tests/generic/179
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/180 b/tests/generic/180
index af2abf9..423f985 100755
--- a/tests/generic/180
+++ b/tests/generic/180
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fzero"
diff --git a/tests/generic/181 b/tests/generic/181
index bd884df..4a3107e 100755
--- a/tests/generic/181
+++ b/tests/generic/181
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/182 b/tests/generic/182
index 7fafec0..94b20a2 100755
--- a/tests/generic/182
+++ b/tests/generic/182
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_dedupe
 
 rm -f $seqres.full
diff --git a/tests/generic/183 b/tests/generic/183
index 24adf97..b72f002 100755
--- a/tests/generic/183
+++ b/tests/generic/183
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_odirect
 
diff --git a/tests/generic/185 b/tests/generic/185
index 49feaf3..f350986 100755
--- a/tests/generic/185
+++ b/tests/generic/185
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 
 rm -f $seqres.full
diff --git a/tests/generic/186 b/tests/generic/186
index 5de120a..def8af9 100755
--- a/tests/generic/186
+++ b/tests/generic/186
@@ -50,6 +50,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/187 b/tests/generic/187
index 3f534c8..b78e91f 100755
--- a/tests/generic/187
+++ b/tests/generic/187
@@ -50,6 +50,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/188 b/tests/generic/188
index 19d3f56..2d693eb 100755
--- a/tests/generic/188
+++ b/tests/generic/188
@@ -47,6 +47,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/189 b/tests/generic/189
index 14cfef9..0ac2366 100755
--- a/tests/generic/189
+++ b/tests/generic/189
@@ -47,6 +47,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/190 b/tests/generic/190
index 3009bfe..7ead187 100755
--- a/tests/generic/190
+++ b/tests/generic/190
@@ -47,6 +47,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/191 b/tests/generic/191
index 36af284..4635789 100755
--- a/tests/generic/191
+++ b/tests/generic/191
@@ -47,6 +47,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/194 b/tests/generic/194
index 9edbe2c..65133c1 100755
--- a/tests/generic/194
+++ b/tests/generic/194
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/195 b/tests/generic/195
index 98954d5..491f2fa 100755
--- a/tests/generic/195
+++ b/tests/generic/195
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/196 b/tests/generic/196
index 69e7c04..384fbac 100755
--- a/tests/generic/196
+++ b/tests/generic/196
@@ -47,6 +47,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/197 b/tests/generic/197
index 0fc0c5e..5c5b352 100755
--- a/tests/generic/197
+++ b/tests/generic/197
@@ -47,6 +47,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/199 b/tests/generic/199
index 0ac4762..697721e 100755
--- a/tests/generic/199
+++ b/tests/generic/199
@@ -51,6 +51,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/200 b/tests/generic/200
index 5d7da84..6f5443b 100755
--- a/tests/generic/200
+++ b/tests/generic/200
@@ -51,6 +51,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/201 b/tests/generic/201
index 547f194..4e87920 100755
--- a/tests/generic/201
+++ b/tests/generic/201
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/202 b/tests/generic/202
index 14c94af..877ba28 100755
--- a/tests/generic/202
+++ b/tests/generic/202
@@ -42,6 +42,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/203 b/tests/generic/203
index a7d0bcc..a18f716 100755
--- a/tests/generic/203
+++ b/tests/generic/203
@@ -42,6 +42,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/205 b/tests/generic/205
index 564afc0..5edb75e 100755
--- a/tests/generic/205
+++ b/tests/generic/205
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 
 rm -f $seqres.full
diff --git a/tests/generic/206 b/tests/generic/206
index 3fdbec2..a9f6003 100755
--- a/tests/generic/206
+++ b/tests/generic/206
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_odirect
 
diff --git a/tests/generic/216 b/tests/generic/216
index 93b0106..a1b7440 100755
--- a/tests/generic/216
+++ b/tests/generic/216
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/217 b/tests/generic/217
index 509f2c4..74557d7 100755
--- a/tests/generic/217
+++ b/tests/generic/217
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/218 b/tests/generic/218
index 92bc521..8dd16c3 100755
--- a/tests/generic/218
+++ b/tests/generic/218
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/220 b/tests/generic/220
index 2bd0e99..10afd30 100755
--- a/tests/generic/220
+++ b/tests/generic/220
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/222 b/tests/generic/222
index eb2169c..8265bc6 100755
--- a/tests/generic/222
+++ b/tests/generic/222
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/227 b/tests/generic/227
index 3fe2490..f3b0e2e 100755
--- a/tests/generic/227
+++ b/tests/generic/227
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/229 b/tests/generic/229
index 55f875d..1b9067c 100755
--- a/tests/generic/229
+++ b/tests/generic/229
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/238 b/tests/generic/238
index c60799d..fa5d4ef 100755
--- a/tests/generic/238
+++ b/tests/generic/238
@@ -46,6 +46,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/242 b/tests/generic/242
index 1bfeb77..5312e62 100755
--- a/tests/generic/242
+++ b/tests/generic/242
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/243 b/tests/generic/243
index 59ae6e8..9e5c6b3 100755
--- a/tests/generic/243
+++ b/tests/generic/243
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/250 b/tests/generic/250
index 3c4fe6d..af749ae 100755
--- a/tests/generic/250
+++ b/tests/generic/250
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch
 _require_dm_target error
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/252 b/tests/generic/252
index ffedd56..daec114 100755
--- a/tests/generic/252
+++ b/tests/generic/252
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch
 _require_dm_target error
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/253 b/tests/generic/253
index 4935f44..06eee73 100755
--- a/tests/generic/253
+++ b/tests/generic/253
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "truncate"
diff --git a/tests/generic/254 b/tests/generic/254
index cd015ec..1e922d3 100755
--- a/tests/generic/254
+++ b/tests/generic/254
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/259 b/tests/generic/259
index 3765bfd..1d0bfe5 100755
--- a/tests/generic/259
+++ b/tests/generic/259
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fzero"
diff --git a/tests/generic/261 b/tests/generic/261
index 84ebc86..574ca1d 100755
--- a/tests/generic/261
+++ b/tests/generic/261
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fcollapse"
diff --git a/tests/generic/262 b/tests/generic/262
index 366801b..d1c8a2d 100755
--- a/tests/generic/262
+++ b/tests/generic/262
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "finsert"
diff --git a/tests/generic/264 b/tests/generic/264
index f90de03..450699c 100755
--- a/tests/generic/264
+++ b/tests/generic/264
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "funshare"
diff --git a/tests/generic/265 b/tests/generic/265
index ceddfbe..291e43c 100755
--- a/tests/generic/265
+++ b/tests/generic/265
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/266 b/tests/generic/266
index 09541c8..9b8004d 100755
--- a/tests/generic/266
+++ b/tests/generic/266
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/267 b/tests/generic/267
index 2ec6ad9..a3c15d6 100755
--- a/tests/generic/267
+++ b/tests/generic/267
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/268 b/tests/generic/268
index b7d16ab..c021b89 100755
--- a/tests/generic/268
+++ b/tests/generic/268
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/271 b/tests/generic/271
index 9439327..8181b43 100755
--- a/tests/generic/271
+++ b/tests/generic/271
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/272 b/tests/generic/272
index 243adf5..6729a00 100755
--- a/tests/generic/272
+++ b/tests/generic/272
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/276 b/tests/generic/276
index 34b0029..40f3dad 100755
--- a/tests/generic/276
+++ b/tests/generic/276
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/278 b/tests/generic/278
index d751f01..fefc77b 100755
--- a/tests/generic/278
+++ b/tests/generic/278
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/279 b/tests/generic/279
index 4541de3..1f06d21 100755
--- a/tests/generic/279
+++ b/tests/generic/279
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/281 b/tests/generic/281
index e8e1661..7cf606d 100755
--- a/tests/generic/281
+++ b/tests/generic/281
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/282 b/tests/generic/282
index 8a30811..5feaebe 100755
--- a/tests/generic/282
+++ b/tests/generic/282
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/283 b/tests/generic/283
index 7bfdb4d..8ead945 100755
--- a/tests/generic/283
+++ b/tests/generic/283
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/284 b/tests/generic/284
index b3e8f3b..2a9642e 100755
--- a/tests/generic/284
+++ b/tests/generic/284
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/287 b/tests/generic/287
index 7d53883..04450ca 100755
--- a/tests/generic/287
+++ b/tests/generic/287
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/289 b/tests/generic/289
index 62b28dc..403e633 100755
--- a/tests/generic/289
+++ b/tests/generic/289
@@ -50,6 +50,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/290 b/tests/generic/290
index ff3af20..5990e84 100755
--- a/tests/generic/290
+++ b/tests/generic/290
@@ -50,6 +50,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/291 b/tests/generic/291
index 1888043..7294d4d 100755
--- a/tests/generic/291
+++ b/tests/generic/291
@@ -50,6 +50,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/292 b/tests/generic/292
index e71b555..0dde6a9 100755
--- a/tests/generic/292
+++ b/tests/generic/292
@@ -50,6 +50,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/293 b/tests/generic/293
index 6792f10..c564f48 100755
--- a/tests/generic/293
+++ b/tests/generic/293
@@ -51,6 +51,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/295 b/tests/generic/295
index 8f7916e..99b7393 100755
--- a/tests/generic/295
+++ b/tests/generic/295
@@ -51,6 +51,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/296 b/tests/generic/296
index 31c8e89..4c2ebc8 100755
--- a/tests/generic/296
+++ b/tests/generic/296
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/297 b/tests/generic/297
index f7eb37b..a4c779f 100755
--- a/tests/generic/297
+++ b/tests/generic/297
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_command "$(which timeout)" "timeout"
diff --git a/tests/generic/298 b/tests/generic/298
index b518da1..8ab65e5 100755
--- a/tests/generic/298
+++ b/tests/generic/298
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_command "$(which timeout)" "timeout"
diff --git a/tests/generic/301 b/tests/generic/301
index 67b1a0c..6cc45ed 100755
--- a/tests/generic/301
+++ b/tests/generic/301
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_fiemap
diff --git a/tests/generic/302 b/tests/generic/302
index 3834f98..6fa6e1a 100755
--- a/tests/generic/302
+++ b/tests/generic/302
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_fiemap
diff --git a/tests/generic/303 b/tests/generic/303
index 3c84008..8f9b8dc 100755
--- a/tests/generic/303
+++ b/tests/generic/303
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/304 b/tests/generic/304
index 6c36a68..f3ae71b 100755
--- a/tests/generic/304
+++ b/tests/generic/304
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_test_dedupe
 _require_cp_reflink
 
diff --git a/tests/generic/305 b/tests/generic/305
index ceef333..5e721a4 100755
--- a/tests/generic/305
+++ b/tests/generic/305
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_fiemap
diff --git a/tests/generic/324 b/tests/generic/324
index 47cb3db..60e425c 100755
--- a/tests/generic/324
+++ b/tests/generic/324
@@ -41,6 +41,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch
 _require_defrag
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/326 b/tests/generic/326
index 3568efe..00f75dd 100755
--- a/tests/generic/326
+++ b/tests/generic/326
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_fiemap
diff --git a/tests/generic/327 b/tests/generic/327
index 05cfb4a..080b4e4 100755
--- a/tests/generic/327
+++ b/tests/generic/327
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_fiemap
diff --git a/tests/generic/328 b/tests/generic/328
index 21ec9d3..18b80a3 100755
--- a/tests/generic/328
+++ b/tests/generic/328
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_fiemap
diff --git a/tests/generic/329 b/tests/generic/329
index 3991672..5ed4ab8 100755
--- a/tests/generic/329
+++ b/tests/generic/329
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/330 b/tests/generic/330
index f9f82a4..9778caf 100755
--- a/tests/generic/330
+++ b/tests/generic/330
@@ -42,6 +42,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_aiodio "aiocp"
diff --git a/tests/generic/331 b/tests/generic/331
index 9b91459..c1ac1e4 100755
--- a/tests/generic/331
+++ b/tests/generic/331
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/332 b/tests/generic/332
index 1fb5611..b355e6a 100755
--- a/tests/generic/332
+++ b/tests/generic/332
@@ -42,6 +42,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_aiodio "aiocp"
diff --git a/tests/generic/333 b/tests/generic/333
index 3d874d7..da3c2ab 100755
--- a/tests/generic/333
+++ b/tests/generic/333
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/334 b/tests/generic/334
index fb21d4f..359045e 100755
--- a/tests/generic/334
+++ b/tests/generic/334
@@ -45,6 +45,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/349 b/tests/generic/349
index ae9f8f6..aff377a 100755
--- a/tests/generic/349
+++ b/tests/generic/349
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scsi_debug
 _require_xfs_io_command "fzero"
 
diff --git a/tests/generic/350 b/tests/generic/350
index 0a12e14..3af48f7 100755
--- a/tests/generic/350
+++ b/tests/generic/350
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scsi_debug
 _require_xfs_io_command "fpunch"
 
diff --git a/tests/generic/351 b/tests/generic/351
index e87fc18..b43a8b9 100755
--- a/tests/generic/351
+++ b/tests/generic/351
@@ -47,6 +47,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scsi_debug
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "finsert"
diff --git a/tests/generic/356 b/tests/generic/356
index 51eeb65..e0655b2 100755
--- a/tests/generic/356
+++ b/tests/generic/356
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_swapfile
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/generic/357 b/tests/generic/357
index 0dd0c10..21e771b 100755
--- a/tests/generic/357
+++ b/tests/generic/357
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_swapfile
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/generic/358 b/tests/generic/358
index d9c7245..0f3c688 100755
--- a/tests/generic/358
+++ b/tests/generic/358
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 
 echo "Format and mount"
diff --git a/tests/generic/359 b/tests/generic/359
index 475026d..5cd8907 100755
--- a/tests/generic/359
+++ b/tests/generic/359
@@ -50,6 +50,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs generic
 _require_scratch_reflink
 
 echo "Format and mount"
diff --git a/tests/xfs/040 b/tests/xfs/040
index 7c2a008..c850ca0 100755
--- a/tests/xfs/040
+++ b/tests/xfs/040
@@ -35,6 +35,9 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 . ./common/rc
 . ./common/filter
 
+_supported_os Linux IRIX
+_supported_fs xfs
+
 [ -z "$KWORKAREA" ] && \
 	_notrun "Can't run srcdiff without KWORKAREA set"
 [ -d "$KWORKAREA/fs/xfs" ] || \
diff --git a/tests/xfs/076 b/tests/xfs/076
index 86f9a05..c8c27f8 100755
--- a/tests/xfs/076
+++ b/tests/xfs/076
@@ -77,6 +77,7 @@ _alloc_inodes()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/132 b/tests/xfs/132
index 178e268..66aa133 100755
--- a/tests/xfs/132
+++ b/tests/xfs/132
@@ -60,6 +60,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_test_reflink
 _require_test_lsattr
 _require_cp_reflink
diff --git a/tests/xfs/139 b/tests/xfs/139
index 4ee7ea2..062a90a 100755
--- a/tests/xfs/139
+++ b/tests/xfs/139
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/xfs/140 b/tests/xfs/140
index 74d8f12..741d170 100755
--- a/tests/xfs/140
+++ b/tests/xfs/140
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/xfs/215 b/tests/xfs/215
index c2b9c0e..233a90b 100755
--- a/tests/xfs/215
+++ b/tests/xfs/215
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/218 b/tests/xfs/218
index 31cac44..225f7f8 100755
--- a/tests/xfs/218
+++ b/tests/xfs/218
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/219 b/tests/xfs/219
index 2a8d966..2a7d35c 100755
--- a/tests/xfs/219
+++ b/tests/xfs/219
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/221 b/tests/xfs/221
index 405d2d5..c18e847 100755
--- a/tests/xfs/221
+++ b/tests/xfs/221
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/223 b/tests/xfs/223
index 6654872..84bed81 100755
--- a/tests/xfs/223
+++ b/tests/xfs/223
@@ -49,6 +49,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/224 b/tests/xfs/224
index 376abe1..7003430 100755
--- a/tests/xfs/224
+++ b/tests/xfs/224
@@ -49,6 +49,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/225 b/tests/xfs/225
index 5864677..f594ba3 100755
--- a/tests/xfs/225
+++ b/tests/xfs/225
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/226 b/tests/xfs/226
index 44605b1..db5421c 100755
--- a/tests/xfs/226
+++ b/tests/xfs/226
@@ -48,6 +48,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/228 b/tests/xfs/228
index 9d8e9a9..7481ef3 100755
--- a/tests/xfs/228
+++ b/tests/xfs/228
@@ -52,6 +52,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/230 b/tests/xfs/230
index e42013f..5507ff3 100755
--- a/tests/xfs/230
+++ b/tests/xfs/230
@@ -52,6 +52,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/248 b/tests/xfs/248
index 471205c..3e2c73d 100755
--- a/tests/xfs/248
+++ b/tests/xfs/248
@@ -49,6 +49,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/249 b/tests/xfs/249
index 0a7fbf1..214c804 100755
--- a/tests/xfs/249
+++ b/tests/xfs/249
@@ -49,6 +49,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/251 b/tests/xfs/251
index 48a027c..da584dd 100755
--- a/tests/xfs/251
+++ b/tests/xfs/251
@@ -51,6 +51,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/254 b/tests/xfs/254
index ac87e49..6262506 100755
--- a/tests/xfs/254
+++ b/tests/xfs/254
@@ -51,6 +51,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/255 b/tests/xfs/255
index 97cbb77..a608068 100755
--- a/tests/xfs/255
+++ b/tests/xfs/255
@@ -51,6 +51,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/256 b/tests/xfs/256
index a182953..b55fbcb 100755
--- a/tests/xfs/256
+++ b/tests/xfs/256
@@ -51,6 +51,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/257 b/tests/xfs/257
index 1fc401b..75aab21 100755
--- a/tests/xfs/257
+++ b/tests/xfs/257
@@ -52,6 +52,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/258 b/tests/xfs/258
index a3ffc89..e58eb97 100755
--- a/tests/xfs/258
+++ b/tests/xfs/258
@@ -52,6 +52,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/269 b/tests/xfs/269
index 318dd22..e540080 100755
--- a/tests/xfs/269
+++ b/tests/xfs/269
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs xfs
 _require_scratch
 _require_populate_commands
 _require_test_program "attr-list-by-handle-cursor-test"
-- 
2.9.3

