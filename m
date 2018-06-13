Received: from mail-pl0-f67.google.com ([209.85.160.67]:40600 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932661AbeFMCah (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Jun 2018 22:30:37 -0400
Date: Wed, 13 Jun 2018 10:30:30 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic: add test for fsync of directory after creating
 hard link
Message-ID: <20180613023030.GB2780@desktop>
References: <20180611182435.18150-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611182435.18150-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 11, 2018 at 07:24:35PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we create a new hard link for a file which was previously
> fsync'ed, fsync a parent directory of the new hard link and power fail,
> the parent directory exists after mounting the filesystem again. The
> parent directory must be a new directory, not yet persisted.
> 
> This test is motivated by a bug found in btrfs, where the fsync'ed parent
> directory was lost after a power failure. The bug in btrfs is fixed by a
> patch for the linux kernel titled:
> 
>  "Btrfs: sync log after logging new name"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks good to me.

> ---
>  tests/generic/498     | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/498.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 68 insertions(+)
>  create mode 100755 tests/generic/498
>  create mode 100644 tests/generic/498.out
> 
> diff --git a/tests/generic/498 b/tests/generic/498
> new file mode 100755
> index 00000000..1cf73bda
> --- /dev/null
> +++ b/tests/generic/498
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. 498
> +#
> +# Test that if we create a new hard link for a file which was previously
> +# fsync'ed, fsync a parent directory of the new hard link and power fail,
> +# the parent directory exists after mounting the filesystem again.
> +#

Thanks a lot for using new test template!

Eryu
