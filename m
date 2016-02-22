Received: from mx1.redhat.com ([209.132.183.28]:43558 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbcBVDDK (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 21 Feb 2016 22:03:10 -0500
Date: Mon, 22 Feb 2016 11:03:04 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: xfstests configure error with xfsprogs v4.5-rc1
Message-ID: <20160222030304.GV11419@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: xfs@oss.sgi.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

After upgrading to xfsprogs v4.5-rc1 version, xfstests failed to built
because of configure error:

    checking xfs/xfs.h usability... no
    checking xfs/xfs.h presence... yes
    configure: WARNING: xfs/xfs.h: present but cannot be compiled
    configure: WARNING: xfs/xfs.h:     check for missing prerequisite headers?
    configure: WARNING: xfs/xfs.h: see the Autoconf documentation
    configure: WARNING: xfs/xfs.h:     section "Present But Cannot Be Compiled"
    configure: WARNING: xfs/xfs.h: proceeding with the compiler's result
    checking for xfs/xfs.h... no
    
    FATAL ERROR: cannot find a valid <xfs/xfs.h> header file.
    Run "make install-qa" from the xfsprogs source.

and config.log showed:

    configure:4543: checking xfs/xfs.h usability
    configure:4543: ccache gcc -c -g -O2  conftest.c >&5
    In file included from /usr/include/xfs/xfs.h:37:0,
    		 from conftest.c:73:
    /usr/include/xfs/linux.h:145:1: error: unknown type name 'off64_t'
     typedef off64_t  xfs_off_t;
     ^
    configure:4543: $? = 1

It's the change made by commit cb898f157f84 ("linux.h: Use off64_t
instead of loff_t") introduced this error. If I do the following
modifications xfstests compiles without errors:

diff --git a/include/linux.h b/include/linux.h
index cc0f70c..d66436c 100644
--- a/include/linux.h
+++ b/include/linux.h
@@ -142,7 +142,7 @@ platform_discard_blocks(int fd, uint64_t start, uint64_t len)
 #define EFSCORRUPTED   EUCLEAN /* Filesystem is corrupted */
 #define EFSBADCRC      EBADMSG /* Bad CRC detected */
 
-typedef off64_t                xfs_off_t;
+typedef __off64_t              xfs_off_t;
 typedef __uint64_t     xfs_ino_t;
 typedef __uint32_t     xfs_dev_t;
 typedef __int64_t      xfs_daddr_t;

But I'm not sure if it's a proper fix.

Thanks,
Eryu
