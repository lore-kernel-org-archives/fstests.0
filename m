Received: from mail-pl1-f195.google.com ([209.85.214.195]:45890 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfBNGCX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Feb 2019 01:02:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so2539297pls.12
        for <fstests@vger.kernel.org>; Wed, 13 Feb 2019 22:02:23 -0800 (PST)
Date: Thu, 14 Feb 2019 13:50:55 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] cifs: add test that setfattr -x fails non-existing EAs
Message-ID: <20190214055055.GX2713@desktop>
References: <20190211051932.20542-1-lsahlber@redhat.com>
 <20190211051932.20542-2-lsahlber@redhat.com>
 <CAOQ4uxgEkG2hHXcLrc5mB0k5h9kw_QNSw-vJcABt0o7+qccvcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgEkG2hHXcLrc5mB0k5h9kw_QNSw-vJcABt0o7+qccvcA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 11, 2019 at 09:15:28AM +0200, Amir Goldstein wrote:
> Hi Ronnie,
> 
> CC the correct list <fstests@vger.kernel.org>
> 
> On Mon, Feb 11, 2019 at 7:21 AM Ronnie Sahlberg <lsahlber@redhat.com> wrote:
> >
> > We just fixed a bug in cifs.ko where it would incorrectly return success
> > for setfattr -x user.does-not-exist.
> >
> > This patch adds a test case for this.
> >
> > Xfstests already have tests for setfattr -x in generic/097
> > but we can not yet use that test for cifs since we can only support
> > the user namespace.
> 
> Mmm... that's not a reason to write a cifs specific test.
> 1. Your test is not cifs specific so should be generic
> 2. There is a lot of other test coverage cifs is missing from generic/097
> 
> What I suggest is:
> - implement _require_trusted_attrs
> - replace _require_attrs with  _require_trusted_attrs in the few
>   generic tests that use trusted xattrs
> - I counted 5 generic tests and there is also generic/079 that
>   sets trusted xattr via t_immutable and doesn't currently _require_attrs
>   at all. Frankly, it looks like most of those test could use user.* xattrs,
>   but whatever.
> - Anyway, please stay away from the overlay trusted xattr tests.
> - clone generic/097 to a new test that only _require_attrs
>   leaving out the trusted xattrs

Yeah, these suggestions all look good to me,

> 
> After that change, cifs will not fail on the trusted xattr tests
> and instead those tests will be properly skipped for cifs.

and this would be the ideal situation for cifs :)

Thanks,
Eryu
