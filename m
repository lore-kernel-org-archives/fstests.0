Received: from mx1.redhat.com ([209.132.183.28]:47230 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbcAGK12 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 7 Jan 2016 05:27:28 -0500
Date: Thu, 7 Jan 2016 18:27:23 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] fstests: comments to prevent from adding "/" to the
 end of 2 environment variables
Message-ID: <20160107102723.GD21019@eguan.usersys.redhat.com>
References: <1452148649-22451-1-git-send-email-hejianet@gmail.com>
 <1452148649-22451-2-git-send-email-hejianet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452148649-22451-2-git-send-email-hejianet@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Jia He <hejianet@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 07, 2016 at 02:37:28PM +0800, Jia He wrote:
> This adds comments to prevent user from adding "/" to the end of TEST_DIR and 
> SCRATCH_MNT

Instead of adding comments, how about removing the trailing "/" in the
code, something like:

diff --git a/common/config b/common/config
index e82d279..cb34fd7 100644
--- a/common/config
+++ b/common/config
@@ -551,5 +551,10 @@ if [ -z "$CONFIG_INCLUDED" ]; then
 	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
 fi
 
+# canonicalize the mount points
+# this follows symlinks and removes all trailing "/"s
+export TEST_DIR=`readlink -e "$TEST_DIR"`
+export SCRATCH_MNT=`readlink -e "$SCRATCH_MNT"`
+
 # make sure this script returns success
 /bin/true

Thanks,
Eryu
