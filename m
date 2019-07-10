Received: from bhuna.collabora.co.uk ([46.235.227.227]:56470 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfGJTED (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Jul 2019 15:04:03 -0400
From: Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] common/rc: print out kernel version too
References: <20190710175809.13391-1-mfo@canonical.com>
Date: Wed, 10 Jul 2019 15:03:58 -0400
In-Reply-To: <20190710175809.13391-1-mfo@canonical.com> (Mauricio Faria de
        Oliveira's message of "Wed, 10 Jul 2019 14:58:09 -0300")
Message-ID: <85ims9yan5.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Mauricio Faria de Oliveira <mfo@canonical.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Mauricio Faria de Oliveira <mfo@canonical.com> writes:

> The kernel version (uname -v) may also be needed in addition to
> the kernel release (uname -r) in order to properly identify and
> distinguish different kernel builds in some cases/distributions.
>
> For example, in the Ubuntu kernel package the test/debug string
> is usually a suffix to the version field, not the release field.
>
>   $ uname -rv
>   4.15.0-51-generic #55-Ubuntu SMP Wed May 15 14:27:21 UTC 2019
>
>   $ uname -rv
>   4.15.0-51-generic #55+test20190520b1 SMP Mon May 20 11:57:40 -03 2019
>
> Looking at other OSes uname(1) man pages it looks like '-v' is
> quite standard, and the Linux man page only cites '-p' and '-i'
> as non-portable, so the change should be OK. The only caller is
> the 'check' script for the header print out, so it's contained.
>

I'm just considering that -v also prints more clutter like the kernel
build date.  Do you need it? It seems off for the PLATFORM line,
which has stuff not kernel related.  Can you trim the output a
bit to remove it?

Anyway,

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

-- 
Gabriel Krisman Bertazi
