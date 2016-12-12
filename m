Received: from mx1.redhat.com ([209.132.183.28]:50964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbcLLJBX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Dec 2016 04:01:23 -0500
Date: Mon, 12 Dec 2016 17:01:20 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/7] ocfs2: test reflinking to inline data files
Message-ID: <20161212090120.GV29149@eguan.usersys.redhat.com>
References: <148149316504.31093.16129068344227450710.stgit@birch.djwong.org>
 <148149317133.31093.439907074888693999.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148149317133.31093.439907074888693999.stgit@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: ocfs2-devel@oss.oracle.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Dec 11, 2016 at 01:52:51PM -0800, Darrick J. Wong wrote:
> Make sure that we can handle reflinking from and to inline-data files.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  common/reflink       |    2 +
>  tests/ocfs2/001      |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ocfs2/001.out  |   14 ++++++++
>  tests/ocfs2/Makefile |   20 +++++++++++
>  tests/ocfs2/group    |    1 +
>  5 files changed, 124 insertions(+), 1 deletion(-)
>  create mode 100755 tests/ocfs2/001
>  create mode 100644 tests/ocfs2/001.out
>  create mode 100644 tests/ocfs2/Makefile
>  create mode 100644 tests/ocfs2/group
> 
> 
> diff --git a/common/reflink b/common/reflink
> index 9d51729..d048045 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -197,7 +197,7 @@ _cp_reflink() {
>  	file1="$1"
>  	file2="$2"
>  
> -	cp --reflink=always -p "$file1" "$file2"
> +	cp --reflink=always -p -f "$file1" "$file2"

I'm still seeing "File exists" error with this patch, tested with your
ocfs2-vfs-reflink-6 branch, compiled on openSUSE Tumbleweed.

FSTYP         -- ocfs2
PLATFORM      -- Linux/x86_64 bootp-73-5-234 4.9.0-rc8.djwong-ocfs2+
MKFS_OPTIONS  -- --fs-features=local /dev/sda5
MOUNT_OPTIONS -- /dev/sda5 /mnt/testarea/scratch

ocfs2/001        - output mismatch (see /root/xfstests/results//ocfs2/ocfs2/001.out.bad)
    --- tests/ocfs2/001.out     2016-12-12 13:51:38.053909486 +0800
    +++ /root/xfstests/results//ocfs2/ocfs2/001.out.bad 2016-12-12 16:49:35.038882697 +0800
    @@ -1,14 +1,18 @@
     QA output created by 001
    +mkfs.ocfs2 1.8.4
     Format and mount
     Create the original files
     reflink into the start of file2
    +cp: failed to reflink '/mnt/testarea/scratch/test-001/file2' from '/mnt/testarea/scratch/test-001/file1': File exists
     reflink past the stuff in file3
    ...
    (Run 'diff -u tests/ocfs2/001.out /root/xfstests/results//ocfs2/ocfs2/001.out.bad'  to see the entire diff)

--- tests/ocfs2/001.out 2016-12-12 13:51:38.053909486 +0800
+++ /root/xfstests/results//ocfs2/ocfs2/001.out.bad     2016-12-12 16:44:31.991943842 +0800
@@ -1,14 +1,18 @@
 QA output created by 001
+mkfs.ocfs2 1.8.4
 Format and mount
 Create the original files
 reflink into the start of file2
+cp: failed to reflink '/mnt/testarea/scratch/test-001/file2' from '/mnt/testarea/scratch/test-001/file1': File exists
 reflink past the stuff in file3
 reflink an inline-data file to a regular one
+cp: failed to reflink '/mnt/testarea/scratch/test-001/file5' from '/mnt/testarea/scratch/test-001/file4': File exists
 reflink an inline-data file to another inline-data file
+cp: failed to reflink '/mnt/testarea/scratch/test-001/file6' from '/mnt/testarea/scratch/test-001/file4': File exists
 Verify the whole mess
 2d61aa54b58c2e94403fb092c3dbc027  SCRATCH_MNT/test-001/file1
-2d61aa54b58c2e94403fb092c3dbc027  SCRATCH_MNT/test-001/file2
+401b30e3b8b5d629635a5c613cdb7919  SCRATCH_MNT/test-001/file2
 4e68a2e24b6b0f386ab39d01d902293d  SCRATCH_MNT/test-001/file3
 009520053b00386d1173f3988c55d192  SCRATCH_MNT/test-001/file4
-009520053b00386d1173f3988c55d192  SCRATCH_MNT/test-001/file5
-009520053b00386d1173f3988c55d192  SCRATCH_MNT/test-001/file6
+2d61aa54b58c2e94403fb092c3dbc027  SCRATCH_MNT/test-001/file5
+60b725f10c9c85c70d97880dfe8191b3  SCRATCH_MNT/test-001/file6

I did the "reflink into the start of file2" test manually, and strace
showed that it is file1 reports EEXIST.

open("/mnt/ocfs2/testfile1", O_RDONLY)  = 3
fstat(3, {st_mode=S_IFREG|0600, st_size=65536, ...}) = 0
ioctl(3, _IOC(_IOC_WRITE, 0x6f, 0x04, 0x18), 0x7ffc8daf09f0) = -1 EEXIST (File exists)

The same test on XFS works fine. Did I miss anything?

Thanks,
Eryu
