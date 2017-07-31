Received: from mail-qt0-f196.google.com ([209.85.216.196]:36860 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdGaFEz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 31 Jul 2017 01:04:55 -0400
Received: by mail-qt0-f196.google.com with SMTP id c15so11944312qta.3
        for <fstests@vger.kernel.org>; Sun, 30 Jul 2017 22:04:55 -0700 (PDT)
Date: Mon, 31 Jul 2017 01:59:34 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: Re: [PATCH] generic/449: remove unused _require_test
Message-ID: <20170731045933.GA5687@debian.home>
References: <1500879458-3673-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170730032727.GA4836@debian.home>
 <597EA643.3020905@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <597EA643.3020905@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>, Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 31, 2017 at 11:38:43AM +0800, Xiao Yang wrote:
> On 2017/07/30 11:27, Ernesto A. Fern=C3=A1ndez wrote:
> >On Mon, Jul 24, 2017 at 02:57:38PM +0800, Xiao Yang wrote:
> >>Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> >>  _supported_fs generic
> >>  _supported_os Linux
> >>  _require_scratch
> >>-_require_test
> >>  _require_acls
> >>  _require_attrs
> >Hi, I wrote that test, thank you for taking the time to review it.
> >
> >It would seem that _require_acls uses the test device, things could ge=
t
> >weird if it's not there.
> >
> >
> Hi Ernesto A and Eryu,
>=20
> init_rc() have checked if TEST_DEV existed and was mounted, and we
> introduced _require_test to check
> file system consistency on TEST_DEV after running tests.   I think it's=
 not
> necessary to add _require_test.

Ah, I understand now, you are right. My confusion was because _require_te=
st
makes the whole check for TEST_DEV again, and even tries to mount it. I
don't know why that is. Also the header comment of _require_test doesn't
mention the consistency check, perhaps it should.

> I'm not sure about it, so cc Eryu to confirm it.
>=20
> Thanks,
> Xiao Yang.
