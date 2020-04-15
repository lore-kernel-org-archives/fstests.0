Return-Path: <SRS0=LRpr=57=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DD2C2BA19
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Apr 2020 20:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8DF20784
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Apr 2020 20:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437939AbgDOUUh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:20:37 -0400
Received: from sandeen.net ([63.231.237.45]:59718 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437924AbgDOUUf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 15 Apr 2020 16:20:35 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 2A355F8C2B;
        Wed, 15 Apr 2020 15:20:15 -0500 (CDT)
Subject: [PATCH 3/4] fstests: add _require_hardlinks for all necessary tests
From:   Eric Sandeen <sandeen@sandeen.net>
To:     fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
References: <9798d553-0bdd-2b8b-ce3b-3c8d2c37936e@sandeen.net>
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 mQINBE6x99QBEADMR+yNFBc1Y5avoUhzI/sdR9ANwznsNpiCtZlaO4pIWvqQJCjBzp96cpCs
 nQZV32nqJBYnDpBDITBqTa/EF+IrHx8gKq8TaSBLHUq2ju2gJJLfBoL7V3807PQcI18YzkF+
 WL05ODFQ2cemDhx5uLghHEeOxuGj+1AI+kh/FCzMedHc6k87Yu2ZuaWF+Gh1W2ix6hikRJmQ
 vj5BEeAx7xKkyBhzdbNIbbjV/iGi9b26B/dNcyd5w2My2gxMtxaiP7q5b6GM2rsQklHP8FtW
 ZiYO7jsg/qIppR1C6Zr5jK1GQlMUIclYFeBbKggJ9mSwXJH7MIftilGQ8KDvNuV5AbkronGC
 sEEHj2khs7GfVv4pmUUHf1MRIvV0x3WJkpmhuZaYg8AdJlyGKgp+TQ7B+wCjNTdVqMI1vDk2
 BS6Rg851ay7AypbCPx2w4d8jIkQEgNjACHVDU89PNKAjScK1aTnW+HNUqg9BliCvuX5g4z2j
 gJBs57loTWAGe2Ve3cMy3VoQ40Wt3yKK0Eno8jfgzgb48wyycINZgnseMRhxc2c8hd51tftK
 LKhPj4c7uqjnBjrgOVaVBupGUmvLiePlnW56zJZ51BR5igWnILeOJ1ZIcf7KsaHyE6B1mG+X
 dmYtjDhjf3NAcoBWJuj8euxMB6TcQN2MrSXy5wSKaw40evooGwARAQABtCVFcmljIFIuIFNh
 bmRlZW4gPHNhbmRlZW5Ac2FuZGVlbi5uZXQ+iQI7BBMBAgAlAhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgAUCUzMzbAIZAQAKCRAgrhaS4T3e4Fr7D/wO+fenqVvHjq21SCjDCrt8HdVj
 aJ28B1SqSU2toxyg5I160GllAxEHpLFGdbFAhQfBtnmlY9eMjwmJb0sCIrkrB6XNPSPA/B2B
 UPISh0z2odJv35/euJF71qIFgWzp2czJHkHWwVZaZpMWWNvsLIroXoR+uA9c2V1hQFVAJZyk
 EE4xzfm1+oVtjIC12B9tTCuS00pY3AUy21yzNowT6SSk7HAzmtG/PJ/uSB5wEkwldB6jVs2A
 sjOg1wMwVvh/JHilsQg4HSmDfObmZj1d0RWlMWcUE7csRnCE0ZWBMp/ttTn+oosioGa09HAS
 9jAnauznmYg43oQ5Akd8iQRxz5I58F/+JsdKvWiyrPDfYZtFS+UIgWD7x+mHBZ53Qjazszox
 gjwO9ehZpwUQxBm4I0lPDAKw3HJA+GwwiubTSlq5PS3P7QoCjaV8llH1bNFZMz2o8wPANiDx
 5FHgpRVgwLHakoCU1Gc+LXHXBzDXt7Cj02WYHdFzMm2hXaslRdhNGowLo1SXZFXa41KGTlNe
 4di53y9CK5ynV0z+YUa+5LR6RdHrHtgywdKnjeWdqhoVpsWIeORtwWGX8evNOiKJ7j0RsHha
 WrePTubr5nuYTDsQqgc2r4aBIOpeSRR2brlT/UE3wGgy9LY78L4EwPR0MzzecfE1Ws60iSqw
 Pu3vhb7h3bkCDQROsffUARAA0DrUifTrXQzqxO8aiQOC5p9Tz25Np/Tfpv1rofOwL8VPBMvJ
 X4P5l1V2yd70MZRUVgjmCydEyxLJ6G2YyHO2IZTEajUY0Up+b3ErOpLpZwhvgWatjifpj6bB
 SKuDXeThqFdkphF5kAmgfVAIkan5SxWK3+S0V2F/oxstIViBhMhDwI6XsRlnVBoLLYcEilxA
 2FlRUS7MOZGmRJkRtdGD5koVZSM6xVZQSmfEBaYQ/WJBGJQdPy94nnlAVn3lH3+N7pXvNUuC
 GV+t4YUt3tLcRuIpYBCOWlc7bpgeCps5Xa0dIZgJ8Louu6OBJ5vVXjPxTlkFdT0S0/uerCG5
 1u8p6sGRLnUeAUGkQfIUqGUjW2rHaXgWNvzOV6i3tf9YaiXKl3avFaNW1kKBs0T5M1cnlWZU
 Utl6k04lz5OjoNY9J/bGyV3DSlkblXRMK87iLYQSrcV6cFz9PRl4vW1LGff3xRQHngeN5fPx
 ze8X5NE3hb+SSwyMSEqJxhVTXJVfQWWW0dQxP7HNwqmOWYF/6m+1gK/Y2gY3jAQnsWTru4RV
 TZGnKwEPmOCpSUvsTRXsVHgsWJ70qd0yOSjWuiv4b8vmD3+QFgyvCBxPMdP3xsxN5etheLMO
 gRwWpLn6yNFq/xtgs+ECgG+gR78yXQyA7iCs5tFs2OrMqV5juSMGmn0kxJUAEQEAAYkCHwQY
 AQIACQUCTrH31AIbDAAKCRAgrhaS4T3e4BKwD/0ZOOmUNOZCSOLAMjZx3mtYtjYgfUNKi0ki
 YPveGoRWTqbis8UitPtNrG4XxgzLOijSdOEzQwkdOIp/QnZhGNssMejCnsluK0GQd+RkFVWN
 mcQT78hBeGcnEMAXZKq7bkIKzvc06GFmkMbX/gAl6DiNGv0UNAX+5FYh+ucCJZSyAp3sA+9/
 LKjxnTedX0aygXA6rkpX0Y0FvN/9dfm47+LGq7WAqBOyYTU3E6/+Z72bZoG/cG7ANLxcPool
 LOrU43oqFnD8QwcN56y4VfFj3/jDF2MX3xu4v2OjglVjMEYHTCxP3mpxesGHuqOit/FR+mF0
 MP9JGfj6x+bj/9JMBtCW1bY/aPeMdPGTJvXjGtOVYblGZrSjXRn5++Uuy36CvkcrjuziSDG+
 JEexGxczWwN4mrOQWhMT5Jyb+18CO+CWxJfHaYXiLEW7dI1AynL4jjn4W0MSiXpWDUw+fsBO
 Pk6ah10C4+R1Jc7dyUsKksMfvvhRX1hTIXhth85H16706bneTayZBhlZ/hK18uqTX+s0onG/
 m1F3vYvdlE4p2ts1mmixMF7KajN9/E5RQtiSArvKTbfsB6Two4MthIuLuf+M0mI4gPl9SPlf
 fWCYVPhaU9o83y1KFbD/+lh1pjP7bEu/YudBvz7F2Myjh4/9GUAijrCTNeDTDAgvIJDjXuLX pA==
Message-ID: <215d9e5c-2b76-907b-d881-a6177a150260@sandeen.net>
Date:   Wed, 15 Apr 2020 15:20:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9798d553-0bdd-2b8b-ce3b-3c8d2c37936e@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add a new _require function for hardlinks, to test hardlink support
in all tests which need it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: Use full pathname for ln target

diff --git a/common/rc b/common/rc
index 31361d0e..742b99de 100644
--- a/common/rc
+++ b/common/rc
@@ -3493,6 +3493,18 @@ _require_symlinks()
 	rm -f $target $link
 }
 
+_require_hardlinks()
+{
+	local target=`mktemp -p $TEST_DIR`
+	local link=`mktemp -p $TEST_DIR -u`
+	ln $target $link
+	if [ "$?" -ne 0 ]; then
+		rm -f $target
+		_notrun "No hardlink support"
+	fi
+	rm -f $target $link
+}
+
 _require_test_fcntl_advisory_locks()
 {
 	[ "$FSTYP" != "cifs" ] && return 0
diff --git a/tests/generic/002 b/tests/generic/002
index 575ac42b..480b77bc 100755
--- a/tests/generic/002
+++ b/tests/generic/002
@@ -28,6 +28,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_hardlinks
 
 rm -f $seqres.full
 
diff --git a/tests/generic/039 b/tests/generic/039
index daa2e353..27cd6bf5 100755
--- a/tests/generic/039
+++ b/tests/generic/039
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/040 b/tests/generic/040
index 712ae595..b69d8127 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -44,6 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/041 b/tests/generic/041
index 8001e8ce..1674d544 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -48,6 +48,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/056 b/tests/generic/056
index 9caf1166..28920d36 100755
--- a/tests/generic/056
+++ b/tests/generic/056
@@ -37,6 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/057 b/tests/generic/057
index ba51dbb9..91e1d98e 100755
--- a/tests/generic/057
+++ b/tests/generic/057
@@ -37,6 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/065 b/tests/generic/065
index d6a1670b..30f3c32e 100755
--- a/tests/generic/065
+++ b/tests/generic/065
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/089 b/tests/generic/089
index 3d608269..52649596 100755
--- a/tests/generic/089
+++ b/tests/generic/089
@@ -36,6 +36,7 @@ addentries()
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_hardlinks
 
 rm -f $seqres.full
 [ "X$TEST_DIR" = "X" ] && exit 1
diff --git a/tests/generic/090 b/tests/generic/090
index bf38d1c8..db1aeef3 100755
--- a/tests/generic/090
+++ b/tests/generic/090
@@ -36,6 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/104 b/tests/generic/104
index d78689f4..4b6256db 100755
--- a/tests/generic/104
+++ b/tests/generic/104
@@ -31,6 +31,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/106 b/tests/generic/106
index 74d5dc30..e1c859e5 100755
--- a/tests/generic/106
+++ b/tests/generic/106
@@ -30,6 +30,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/107 b/tests/generic/107
index 5c6bbfca..214f3389 100755
--- a/tests/generic/107
+++ b/tests/generic/107
@@ -33,6 +33,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/236 b/tests/generic/236
index f207165f..2110b053 100755
--- a/tests/generic/236
+++ b/tests/generic/236
@@ -25,8 +25,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # real QA test starts here
 _supported_fs generic
-# only Linux supports fallocate
 _supported_os Linux
+_require_hardlinks
 _require_test
 
 rm -f $TEST_DIR/ouch*
diff --git a/tests/generic/336 b/tests/generic/336
index e007552c..6832ccde 100755
--- a/tests/generic/336
+++ b/tests/generic/336
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/343 b/tests/generic/343
index e35488dd..2034197e 100755
--- a/tests/generic/343
+++ b/tests/generic/343
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/378 b/tests/generic/378
index 393d1ce7..ea776949 100755
--- a/tests/generic/378
+++ b/tests/generic/378
@@ -39,6 +39,7 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_user
+_require_hardlinks
 
 # Setup testfile and its hardlink
 testfile=$TEST_DIR/testfile.$seq
diff --git a/tests/generic/480 b/tests/generic/480
index ba2c34ad..63a87519 100755
--- a/tests/generic/480
+++ b/tests/generic/480
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/498 b/tests/generic/498
index 71f5091c..7adf0b32 100755
--- a/tests/generic/498
+++ b/tests/generic/498
@@ -31,6 +31,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/502 b/tests/generic/502
index a60ac9a7..a49ee0b3 100755
--- a/tests/generic/502
+++ b/tests/generic/502
@@ -34,6 +34,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/526 b/tests/generic/526
index d0b51f87..934d263f 100755
--- a/tests/generic/526
+++ b/tests/generic/526
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/527 b/tests/generic/527
index 61dd4f0b..4b664da9 100755
--- a/tests/generic/527
+++ b/tests/generic/527
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full


