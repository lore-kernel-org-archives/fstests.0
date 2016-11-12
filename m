Received: from bombadil.infradead.org ([198.137.202.9]:41235 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbcKLQrU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 Nov 2016 11:47:20 -0500
Received: from hch by bombadil.infradead.org with local (Exim 4.85_2 #1 (Red Hat Linux))
        id 1c5bSa-0004kb-7E
        for fstests@vger.kernel.org; Sat, 12 Nov 2016 16:47:20 +0000
Date: Sat, 12 Nov 2016 08:47:20 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] fstests: fix error redirection in generic/256
Message-ID: <20161112164720.GA18127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Not sure if my shell is the problem here, but I need this explicit
redirection to ignore the error output from mkdir and xfs_io, otherwise
the test fails due to the error messages from these commands.

Signed-off-by: Christoph Hellwig <hch@lst.de>

diff --git a/tests/generic/256 b/tests/generic/256
index cfbf790..2db22cd 100755
--- a/tests/generic/256
+++ b/tests/generic/256
@@ -80,7 +80,7 @@ _fill_fs() {
 	# Creation of files or folders
 	# must not be done as root or
 	# reserved blocks will be consumed
-	_user_do "mkdir -p $dir &> /dev/null"
+	_user_do "mkdir -p $dir > /dev/null 2>&1"
 	if [ $? -ne 0 ] ; then
 		return 0
 	fi
@@ -93,7 +93,7 @@ _fill_fs() {
 	while [ $file_size -ge $block_size ]
 	do
 		bytes_written=0
-		_user_do "$XFS_IO_PROG -f -c \"pwrite 0 $file_size\" $dir/$file_count.bin &> /dev/null"
+		_user_do "$XFS_IO_PROG -f -c \"pwrite 0 $file_size\" $dir/$file_count.bin > /dev/null 2>&1"
 
 		if [ -f $dir/$file_count.bin ]
 		then
