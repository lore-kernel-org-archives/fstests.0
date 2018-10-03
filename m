Received: from mail.kernel.org ([198.145.29.99]:45442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbeJDG2f (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Oct 2018 02:28:35 -0400
Date: Wed, 3 Oct 2018 16:38:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [xfstests-bld PATCH] kernel-configs: fix i386 configs
Message-ID: <20181003233800.GB58226@gmail.com>
References: <20180907010118.234124-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907010118.234124-1-ebiggers@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 06, 2018 at 06:01:18PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Commit 452331adc6c0 ("kernel-configs: enable virtio_9P and 9P_FS")
> removed the explicit unsetting of CONFIG_64BIT from some of the i386
> kconfigs.  So, they actually became x86_64.  Fix it by syncing them back
> up with the x86_64 configs.  I also added the script I used to do this.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  kernel-configs/i386-config-3.18     |  1 +
>  kernel-configs/i386-config-4.1      |  5 +---
>  kernel-configs/i386-config-4.14     |  3 +--
>  kernel-configs/i386-config-4.4      |  4 +--
>  kernel-configs/i386-config-4.9      |  3 +--
>  kernel-configs/sync_i386_configs.sh | 38 +++++++++++++++++++++++++++++
>  6 files changed, 43 insertions(+), 11 deletions(-)
>  create mode 100755 kernel-configs/sync_i386_configs.sh
> 

Hi Ted, are you planning to apply this?  Thanks!

- Eric
