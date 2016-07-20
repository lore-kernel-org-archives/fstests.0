Received: from sandeen.net ([63.231.237.45]:59411 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbcGTFer (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Jul 2016 01:34:47 -0400
Subject: Re: [PATCH] generic/071: require falloc -k
References: <1468829204-24593-1-git-send-email-hch@lst.de>
 <20160718084714.GD27776@eguan.usersys.redhat.com>
 <20160719041718.GA17223@lst.de>
 <7bd28494-84e9-1458-5e28-893d02dd5c06@sandeen.net>
 <20160719083047.GA21083@lst.de>
 <20160720045217.GT27776@eguan.usersys.redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <07f34424-ed2c-4f5f-991b-91981367c1a5@sandeen.net>
Date: Tue, 19 Jul 2016 22:34:43 -0700
MIME-Version: 1.0
In-Reply-To: <20160720045217.GT27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 7/19/16 9:52 PM, Eryu Guan wrote:
> On Tue, Jul 19, 2016 at 10:30:47AM +0200, Christoph Hellwig wrote:
>> On Mon, Jul 18, 2016 at 11:49:57PM -0700, Eric Sandeen wrote:
>>> Some tests actually do run xfs_io on a real file, but we probably
>>> don't want to go that way.
>>>
>>> The test for finding it in help output seems way too specific,
>>>
>>> _require_xfs_io_command "pwrite" "-Z"
>>>
>>> fails as well because it doesn't hit the specific format in
>>> the grep.
>>>
>>> What if we loosen up the test; is this too loose? (look for param
>>> preceded by whitespace or square bracket)
>>
>> Seems like it's not loose enough as it still tries to run the test
>> on NFS.
> 
> For this NFSv4.2 case, I think we have to actually run "falloc -k" to
> check whether the underlying fs supports (FALLOC_FL_KEEP_SIZE) or not.
> 
> Current check in _require_xfs_io_command only checks whether xfs_io
> knows the given option, not the underlying fs. And in this NFSv4.2 case,
> NFSv4.2 supports fallocate(2), and xfs_io falloc command knows "-k"
> option, so test runs on NFS.

Oh right, sorry.  So, this?

diff --git a/common/rc b/common/rc
index 6add69e..f087813 100644
--- a/common/rc
+++ b/common/rc
@@ -1880,7 +1880,7 @@ _require_xfs_io_command()
 	testfile=$TEST_DIR/$$.xfs_io
 	case $command in
 	"falloc" )
-		testio=`$XFS_IO_PROG -F -f -c "falloc 0 1m" $testfile 2>&1`
+		testio=`$XFS_IO_PROG -F -f -c "falloc $param 0 1m" $testfile 2>&1`
 		;;
 	"fpunch" | "fcollapse" | "zero" | "fzero" | "finsert" )
 		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 20k" -c "fsync" \

-Eric
