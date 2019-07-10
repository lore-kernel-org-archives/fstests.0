Received: from youngberry.canonical.com ([91.189.89.112]:34796 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfGJTQz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Jul 2019 15:16:55 -0400
Received: from mail-vk1-f200.google.com ([209.85.221.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1hlI5F-0004Xb-Ny
        for fstests@vger.kernel.org; Wed, 10 Jul 2019 19:16:53 +0000
Received: by mail-vk1-f200.google.com with SMTP id j63so1421393vkc.13
        for <fstests@vger.kernel.org>; Wed, 10 Jul 2019 12:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190710175809.13391-1-mfo@canonical.com> <85ims9yan5.fsf@collabora.com>
In-Reply-To: <85ims9yan5.fsf@collabora.com>
From: Mauricio Faria de Oliveira <mfo@canonical.com>
Date: Wed, 10 Jul 2019 16:16:41 -0300
Message-ID: <CAO9xwp1XuLubBtQAcq8Mah9OQy48d2mO8-QuerC7d2e6Xjrwog@mail.gmail.com>
Subject: Re: [PATCH] common/rc: print out kernel version too
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

,

On Wed, Jul 10, 2019 at 4:04 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Mauricio Faria de Oliveira <mfo@canonical.com> writes:
>
> > The kernel version (uname -v) may also be needed in addition to
> > the kernel release (uname -r) in order to properly identify and
> > distinguish different kernel builds in some cases/distributions.
> >
> > For example, in the Ubuntu kernel package the test/debug string
> > is usually a suffix to the version field, not the release field.
> >
> >   $ uname -rv
> >   4.15.0-51-generic #55-Ubuntu SMP Wed May 15 14:27:21 UTC 2019
> >
> >   $ uname -rv
> >   4.15.0-51-generic #55+test20190520b1 SMP Mon May 20 11:57:40 -03 2019
> >
> > Looking at other OSes uname(1) man pages it looks like '-v' is
> > quite standard, and the Linux man page only cites '-p' and '-i'
> > as non-portable, so the change should be OK. The only caller is
> > the 'check' script for the header print out, so it's contained.
> >
>
> I'm just considering that -v also prints more clutter like the kernel
> build date.  Do you need it? It seems off for the PLATFORM line,
> which has stuff not kernel related.  Can you trim the output a
> bit to remove it?
>

It indeed prints out some clutter that's usually not required,
but it's hard to tell which parts of it may (not) be useful in general
for particular/different users, to consider trimming it,
so the complete string seemed to be the way go IMO.

> Anyway,
>
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Thanks for reviewing.

>
> --
> Gabriel Krisman Bertazi

cheers,


--
Mauricio Faria de Oliveira
