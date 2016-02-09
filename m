Received: from imap.thunk.org ([74.207.234.97]:37959 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932359AbcBIBMb (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 8 Feb 2016 20:12:31 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4/001: add output variant for nodelalloc mounts
Date: Mon,  8 Feb 2016 20:12:25 -0500
Message-Id: <1454980345-25964-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

If the delayed allocation is disabled, we need a slightly different
output for the delayed allocation portion of the tests.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>
---
 tests/ext4/001.cfg            |   2 +
 tests/ext4/001.out.nodelalloc | 337 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 339 insertions(+)
 create mode 100644 tests/ext4/001.out.nodelalloc

diff --git a/tests/ext4/001.cfg b/tests/ext4/001.cfg
index 1942203..5f7e262 100644
--- a/tests/ext4/001.cfg
+++ b/tests/ext4/001.cfg
@@ -1,2 +1,4 @@
 dax: nozero
 dioread_nolock: nozero
+nodelalloc: nodelalloc
+data=journal: nodelalloc
diff --git a/tests/ext4/001.out.nodelalloc b/tests/ext4/001.out.nodelalloc
new file mode 100644
index 0000000..212c247
--- /dev/null
+++ b/tests/ext4/001.out.nodelalloc
@@ -0,0 +1,337 @@
+QA output created by 001
+	1. into a hole
+0: [0..7]: hole
+1: [8..23]: unwritten
+2: [24..39]: hole
+daa100df6e6711906b61c9ab5aa16032
+	2. into allocated space
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	3. into unwritten space
+0: [0..39]: unwritten
+daa100df6e6711906b61c9ab5aa16032
+	4. hole -> data
+0: [0..7]: hole
+1: [8..23]: unwritten
+2: [24..31]: data
+3: [32..39]: hole
+cc63069677939f69a6e8f68cae6a6dac
+	5. hole -> unwritten
+0: [0..7]: hole
+1: [8..31]: unwritten
+2: [32..39]: hole
+daa100df6e6711906b61c9ab5aa16032
+	6. data -> hole
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: hole
+1b3779878366498b28c702ef88c4a773
+	7. data -> unwritten
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: hole
+1b3779878366498b28c702ef88c4a773
+	8. unwritten -> hole
+0: [0..23]: unwritten
+1: [24..39]: hole
+daa100df6e6711906b61c9ab5aa16032
+	9. unwritten -> data
+0: [0..23]: unwritten
+1: [24..31]: data
+2: [32..39]: hole
+cc63069677939f69a6e8f68cae6a6dac
+	10. hole -> data -> hole
+0: [0..7]: hole
+1: [8..31]: unwritten
+2: [32..39]: hole
+daa100df6e6711906b61c9ab5aa16032
+	11. data -> hole -> data
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+f6aeca13ec49e5b266cd1c913cd726e3
+	12. unwritten -> data -> unwritten
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+daa100df6e6711906b61c9ab5aa16032
+	13. data -> unwritten -> data
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+f6aeca13ec49e5b266cd1c913cd726e3
+	14. data -> hole @ EOF
+0: [0..23]: data
+1: [24..39]: unwritten
+e1f024eedd27ea6b1c3e9b841c850404
+	15. data -> hole @ 0
+0: [0..15]: unwritten
+1: [16..39]: data
+eecb7aa303d121835de05028751d301c
+	16. data -> cache cold ->hole
+0: [0..15]: unwritten
+1: [16..39]: data
+eecb7aa303d121835de05028751d301c
+	17. data -> hole in single block file
+0: [0..7]: data
+0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+0000200 0000 0000 0000 0000 0000 0000 0000 0000
+*
+0000400 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+	1. into a hole
+0: [0..7]: hole
+1: [8..23]: unwritten
+2: [24..39]: hole
+daa100df6e6711906b61c9ab5aa16032
+	2. into allocated space
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	3. into unwritten space
+0: [0..39]: unwritten
+daa100df6e6711906b61c9ab5aa16032
+	4. hole -> data
+0: [0..7]: hole
+1: [8..23]: unwritten
+2: [24..31]: data
+3: [32..39]: hole
+cc63069677939f69a6e8f68cae6a6dac
+	5. hole -> unwritten
+0: [0..7]: hole
+1: [8..31]: unwritten
+2: [32..39]: hole
+daa100df6e6711906b61c9ab5aa16032
+	6. data -> hole
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: hole
+1b3779878366498b28c702ef88c4a773
+	7. data -> unwritten
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: hole
+1b3779878366498b28c702ef88c4a773
+	8. unwritten -> hole
+0: [0..23]: unwritten
+1: [24..39]: hole
+daa100df6e6711906b61c9ab5aa16032
+	9. unwritten -> data
+0: [0..23]: unwritten
+1: [24..31]: data
+2: [32..39]: hole
+cc63069677939f69a6e8f68cae6a6dac
+	10. hole -> data -> hole
+0: [0..7]: hole
+1: [8..31]: unwritten
+2: [32..39]: hole
+daa100df6e6711906b61c9ab5aa16032
+	11. data -> hole -> data
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+f6aeca13ec49e5b266cd1c913cd726e3
+	12. unwritten -> data -> unwritten
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+daa100df6e6711906b61c9ab5aa16032
+	13. data -> unwritten -> data
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+f6aeca13ec49e5b266cd1c913cd726e3
+	14. data -> hole @ EOF
+0: [0..23]: data
+1: [24..39]: unwritten
+e1f024eedd27ea6b1c3e9b841c850404
+	15. data -> hole @ 0
+0: [0..15]: unwritten
+1: [16..39]: data
+eecb7aa303d121835de05028751d301c
+	16. data -> cache cold ->hole
+0: [0..15]: unwritten
+1: [16..39]: data
+eecb7aa303d121835de05028751d301c
+	17. data -> hole in single block file
+0: [0..7]: data
+0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+0000200 0000 0000 0000 0000 0000 0000 0000 0000
+*
+0000400 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+	1. into a hole
+0: [0..7]: hole
+1: [8..23]: unwritten
+2: [24..39]: hole
+daa100df6e6711906b61c9ab5aa16032
+	2. into allocated space
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	3. into unwritten space
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	4. hole -> data
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	5. hole -> unwritten
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	6. data -> hole
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	7. data -> unwritten
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	8. unwritten -> hole
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	9. unwritten -> data
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	10. hole -> data -> hole
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+f6aeca13ec49e5b266cd1c913cd726e3
+	11. data -> hole -> data
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+f6aeca13ec49e5b266cd1c913cd726e3
+	12. unwritten -> data -> unwritten
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+f6aeca13ec49e5b266cd1c913cd726e3
+	13. data -> unwritten -> data
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+f6aeca13ec49e5b266cd1c913cd726e3
+	14. data -> hole @ EOF
+0: [0..23]: data
+1: [24..39]: unwritten
+e1f024eedd27ea6b1c3e9b841c850404
+	15. data -> hole @ 0
+0: [0..15]: unwritten
+1: [16..39]: data
+eecb7aa303d121835de05028751d301c
+	16. data -> cache cold ->hole
+0: [0..15]: unwritten
+1: [16..39]: data
+eecb7aa303d121835de05028751d301c
+	17. data -> hole in single block file
+0: [0..7]: data
+0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+0000200 0000 0000 0000 0000 0000 0000 0000 0000
+*
+0000400 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+	1. into a hole
+0: [0..7]: hole
+1: [8..23]: unwritten
+2: [24..39]: hole
+daa100df6e6711906b61c9ab5aa16032
+	2. into allocated space
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	3. into unwritten space
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	4. hole -> data
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	5. hole -> unwritten
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	6. data -> hole
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	7. data -> unwritten
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	8. unwritten -> hole
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	9. unwritten -> data
+0: [0..7]: data
+1: [8..23]: unwritten
+2: [24..39]: data
+cc58a7417c2d7763adc45b6fcd3fa024
+	10. hole -> data -> hole
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+f6aeca13ec49e5b266cd1c913cd726e3
+	11. data -> hole -> data
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+f6aeca13ec49e5b266cd1c913cd726e3
+	12. unwritten -> data -> unwritten
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+f6aeca13ec49e5b266cd1c913cd726e3
+	13. data -> unwritten -> data
+0: [0..7]: data
+1: [8..31]: unwritten
+2: [32..39]: data
+f6aeca13ec49e5b266cd1c913cd726e3
+	14. data -> hole @ EOF
+0: [0..23]: data
+1: [24..39]: unwritten
+e1f024eedd27ea6b1c3e9b841c850404
+	15. data -> hole @ 0
+0: [0..15]: unwritten
+1: [16..39]: data
+eecb7aa303d121835de05028751d301c
+	16. data -> cache cold ->hole
+0: [0..15]: unwritten
+1: [16..39]: data
+eecb7aa303d121835de05028751d301c
+	17. data -> hole in single block file
+0: [0..7]: data
+0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+0000200 0000 0000 0000 0000 0000 0000 0000 0000
+*
+0000400 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
-- 
2.5.0

