Received: from mail-it0-f65.google.com ([209.85.214.65]:36169 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbdK2USH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Nov 2017 15:18:07 -0500
Received: by mail-it0-f65.google.com with SMTP id d16so5704555itj.1
        for <fstests@vger.kernel.org>; Wed, 29 Nov 2017 12:18:07 -0800 (PST)
Date: Wed, 29 Nov 2017 12:18:04 -0800
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [xfstests-bld PATCH] kernel-configs: add 4.14 configs
Message-ID: <20171129201804.GA65846@gmail.com>
References: <20171113213752.18123-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171113213752.18123-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 13, 2017 at 01:37:52PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Enabled the following new options:
> 
>     CONFIG_REFCOUNT_FULL=y
>     CONFIG_UBIFS_FS_ENCRYPTION=y
>     CONFIG_FORTIFY_SOURCE=y
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  kernel-configs/i386-config-4.14   | 169 ++++++++++++++++++++++++++++++++++++
>  kernel-configs/x86_64-config-4.14 | 174 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 343 insertions(+)
>  create mode 100644 kernel-configs/i386-config-4.14
>  create mode 100644 kernel-configs/x86_64-config-4.14

Ping
