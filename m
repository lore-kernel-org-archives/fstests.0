Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43069 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbaLORcH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 12:32:07 -0500
Date: Tue, 16 Dec 2014 01:32:00 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] ext4/308,generic/324: require fallocate support
Message-ID: <20141215172937.GX15495@dhcp-13-216.nay.redhat.com>
References: <1418658443-31670-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418658443-31670-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 15, 2014 at 10:47:23AM -0500, Theodore Ts'o wrote:
> These tests use the falloc command in xfs_io, and there are some file
> systems (ext3) or file system configurations (ext4 in ext3
> compatibility mode) which do not support fallocate.  So add the
> explicit requirement to avoid false test failures.

The two tests fail because of no defrag support on ext3 on my test host.

ext4/308         [not run] defragmentation not supported for fstype "ext3"                                                                                     
generic/324 19s ... [not run] defragmentation not supported for fstype "ext3"

But the check makes sense to me.

> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/ext4/308    | 1 +
>  tests/generic/324 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/ext4/308 b/tests/ext4/308
> index 8df24ba..948ff3f 100755
> --- a/tests/ext4/308
> +++ b/tests/ext4/308
> @@ -46,6 +46,7 @@ _supported_os Linux
>  _need_to_be_root
>  _require_scratch
>  _require_defrag
> +_require_xfs_io_command "falloc"

ext4/308 also uses fiemap command, I think we need another check here

_require_xfs_io_command "fiemap"

Thanks,
Eryu
