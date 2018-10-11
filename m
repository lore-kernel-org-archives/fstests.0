Received: from mail-yb1-f196.google.com ([209.85.219.196]:37973 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeJKT2n (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Oct 2018 15:28:43 -0400
Received: by mail-yb1-f196.google.com with SMTP id e190-v6so3489814ybb.5
        for <fstests@vger.kernel.org>; Thu, 11 Oct 2018 05:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180905190700.66123-1-ebiggers@kernel.org> <20180915193657.GC9979@thunk.org>
 <20181003233717.GA58226@gmail.com> <20181004023502.GA646@thunk.org>
In-Reply-To: <20181004023502.GA646@thunk.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Oct 2018 15:01:36 +0300
Message-ID: <CAOQ4uxibDWQPh_Vno9s2RUXkrkSR0kStd2r3UXpaK_XV681oVg@mail.gmail.com>
Subject: Re: [PATCH resend] android-xfstests: fix finding FS_TYPE when
 userdata is on dm device
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: ebiggers@kernel.org, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 4, 2018 at 5:35 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Oct 03, 2018 at 04:37:18PM -0700, Eric Biggers wrote:
> >
> > Hi Ted, are you planning to push this out?
> >
>
> Oops, sorry.   Pushed out now.
>

Ted,

FYI, this is pushed to github, but not kernel.org tree.
Intentional?

FYI2, I started trying to build a kvm-xfstests image with Debian buster.
First thing I ran into with setup-buildchroot is that golang-1.8-go
package is not available.
I suppose golang is for syzbot? Their wiki recommends to use
golang-go for debian based releases, which does work for buster.

Now I hit an error in ./gen-image:
W: Couldn't download package openssl (ver 1.1.0f-3+deb9u1 arch amd64) at
http://mirrors.kernel.org/debian/pool/main/o/openssl/openssl_1.1.0f-3+deb9u1_amd64.deb
I see that this pkg doesn't exist in the mirror, but this pkg does
exists (deb9u2):
http://mirrors.edge.kernel.org/debian/pool/main/o/openssl/openssl_1.1.0f-3+deb9u2_amd64.deb

Do you know what that is about?

Thanks,
Amir.
