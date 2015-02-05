Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:14800 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752540AbbBECUL (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 4 Feb 2015 21:20:11 -0500
Date: Thu, 5 Feb 2015 13:19:57 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 5/8 v4] tests/generic: relocate xfs's tests into
 tests/generic/
Message-ID: <20150205021957.GF12722@dastard>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
 <1423004840-45315-6-git-send-email-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1423004840-45315-6-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 03, 2015 at 03:07:17PM -0800, Jaegeuk Kim wrote:
> This patch moves the generic testcases defined in xfs into tests/generic/.
> * xfs/053 -> generic/054
>   xfs/137 -> generic/137
>   xfs/138 -> generic/138
>   xfs/139 -> generic/139
>   xfs/140 -> generic/140
>   xfs/179 -> generic/179
>   xfs/180 -> generic/180
>   xfs/182 -> generic/182
>   xfs/200 -> generic/200
> * xfs/306 -> generic/305
> 
> * The test number was changed to address conflicts.

Just rename them all to the lowest unused numbers in the generic/ test
directory.

> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  tests/generic/054     | 102 ++++++++++++++++++++++++++++++++++++++++
>  tests/generic/054.out |  10 ++++

You should tell git to use a diff format that track renames. i.e

$ git diff -M 97bf6af..2155355
diff --git a/fs/xfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
similarity index 100%
rename from fs/xfs/xfs_fs.h
rename to fs/xfs/libxfs/xfs_fs.h
$
$
$ git diff --stat -M 97bf6af..2155355
 fs/xfs/{ => libxfs}/xfs_fs.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
$

It's much easier to review rename patches in this format. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
