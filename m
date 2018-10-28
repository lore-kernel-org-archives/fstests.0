Received: from mail-pf1-f193.google.com ([209.85.210.193]:34502 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJ1WEQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Oct 2018 18:04:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id f78-v6so2699827pfe.1
        for <fstests@vger.kernel.org>; Sun, 28 Oct 2018 06:19:38 -0700 (PDT)
Date: Sun, 28 Oct 2018 21:19:21 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 2/2] fstests: add some tests to the 'log' group that use
 dmflakey
Message-ID: <20181028131921.GC3876@desktop>
References: <20181027084858.1953-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027084858.1953-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Oct 27, 2018 at 09:48:58AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some tests that use dmflakey to test filesystem consistency after a power
> failure are in the 'log' group while others are not. So fix the
> incosistency and put them all under the 'log' group.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/group   | 14 +++++++-------
>  tests/generic/group | 48 ++++++++++++++++++++++++------------------------
>  tests/shared/group  |  2 +-
>  3 files changed, 32 insertions(+), 32 deletions(-)
>  mode change 100644 => 100755 tests/btrfs/group
>  mode change 100644 => 100755 tests/generic/group

I assume the file mode changes are made by mistake, will fix the mode on
commit.

Thanks,
Eryu
