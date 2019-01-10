Received: from mail-pl1-f196.google.com ([209.85.214.196]:44988 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfAJIf6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 Jan 2019 03:35:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so4882175plt.11
        for <fstests@vger.kernel.org>; Thu, 10 Jan 2019 00:35:56 -0800 (PST)
Date: Thu, 10 Jan 2019 16:35:49 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/423: statx mask of the reference file is
 different from the original file
Message-ID: <20190110083549.GF2803@desktop>
References: <1547090099-8394-1-git-send-email-cuiyue-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547090099-8394-1-git-send-email-cuiyue-fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Cui Yue <cuiyue-fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 09, 2019 at 10:14:59PM -0500, Cui Yue wrote:
> When running xfstests generic/423 to test system call statx() on hard link files of NFS, it fails.
> error message:
> [!] attr 'stx_mask' differs from ref file, 7ff != e0
> 
> The values of parameter "mask" between the original file and the reference file are different.
> One is STATX_ALL;
> The other is STATX_ATIME | STATX_BTIME | STATX_CTIME | STATX_MTIME.
> 
> Modify the function get_reference() to pass the "mask" in,
> and change STATX_ATIME | STATX_BTIME | STATX_CTIME | STATX_MTIME to "mask".

Thanks for the fix! Patch looks fine to me, but please follow the kernel
rules for submitting patches in the future. The commit log has too long
lines and you're missing Signed-off-by tag. I'll do the update at commit
time, no need to resend.

Thanks,
Eryu
