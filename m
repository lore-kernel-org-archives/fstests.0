Received: from sandeen.net ([63.231.237.45]:35426 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbcGSGuG (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 19 Jul 2016 02:50:06 -0400
Subject: Re: [PATCH] generic/071: require falloc -k
References: <1468829204-24593-1-git-send-email-hch@lst.de>
 <20160718084714.GD27776@eguan.usersys.redhat.com>
 <20160719041718.GA17223@lst.de>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <7bd28494-84e9-1458-5e28-893d02dd5c06@sandeen.net>
Date: Mon, 18 Jul 2016 23:49:57 -0700
MIME-Version: 1.0
In-Reply-To: <20160719041718.GA17223@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 7/18/16 9:17 PM, Christoph Hellwig wrote:
> On Mon, Jul 18, 2016 at 04:47:14PM +0800, Eryu Guan wrote:
>> This stops generic/071 from running no matter what filesystem it's
>> testing, this is because _require_xfs_io_command only checks whether
>> xfs_io knows the option (-k) by searching it in help message, not really
>> running it, i.e.
> 
> Well, we can at least add the documentation as that would be useful
> on it's own.  I'll look into a patch.
> 
>> Perhaps we should update _require_xfs_io_command to actually run the
>> command with the provided additional option?
> 
> I'll have to look at the archives, but I remember we had a reason for
> this way of probing for feature support.

Some tests actually do run xfs_io on a real file, but we probably
don't want to go that way.

The test for finding it in help output seems way too specific,

_require_xfs_io_command "pwrite" "-Z"

fails as well because it doesn't hit the specific format in
the grep.

What if we loosen up the test; is this too loose? (look for param
preceded by whitespace or square bracket)

diff --git a/common/rc b/common/rc
index 6add69e..0eef3d5 100644
--- a/common/rc
+++ b/common/rc
@@ -1907,7 +1907,7 @@ _require_xfs_io_command()
 		_notrun "xfs_io $command failed (old kernel/wrong fs?)"
 
 	test -z "$param" && return
-	$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
+	$XFS_IO_PROG -c "help $command" | egrep -qw "[ \[]$param" || \
 		_notrun "xfs_io $command doesn't support $param"
 }
 
