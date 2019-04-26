Received: from mx2.suse.de ([195.135.220.15]:51310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfDZL3t (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 26 Apr 2019 07:29:49 -0400
Date: Fri, 26 Apr 2019 13:30:52 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: Obsolete test? (Was: Re: [PATCH v3] generic/390: Add tests for
 inode timestamp policy)
Message-ID: <20190426113052.GO20156@suse.cz>
Reply-To: dsterba@suse.cz
References: <1483501871-15389-1-git-send-email-deepa.kernel@gmail.com>
 <20190425174453.GN20156@twin.jikos.cz>
 <CABeXuvqjwNYL4yctJpywW7Ogjm0=yWU7aVrxC_Pu-ggQT+1-kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABeXuvqjwNYL4yctJpywW7Ogjm0=yWU7aVrxC_Pu-ggQT+1-kQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: fstests@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 25, 2019 at 02:23:55PM -0700, Deepa Dinamani wrote:
> > On Apr 25, 2019, at 10:44 AM, David Sterba <dsterba@suse.cz> wrote:
> >
> >> On Tue, Jan 03, 2017 at 07:51:11PM -0800, Deepa Dinamani wrote:
> >> The test helps to validate clamping and mount behaviors
> >> according to supported file system timestamp ranges.
> >>
> >> Note that the test can fail on 32-bit systems for a
> >> few file systems. This will be corrected when vfs is
> >> transitioned to use 64-bit timestamps.
> >>
> >> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> >> ---
> >> The branch of the kernel tree can be located at
> >>
> >> https://github.com/deepa-hub/vfs refs/heads/vfs_timestamp_policy
> >
> > It's 2019 and the functionality hasn't been merged to kernel, but may=
be
> > there's a replacement I have missed.
> >
> >> +# timestamp ranges support.
> >> +_require_y2038()
> >> +{
> >> +    local device=3D${1:-$TEST_DEV}
> >> +    local sysfsdir=3D/proc/sys/fs/fs-timestamp-check-on
> >> +
> >> +    if [ ! -e $sysfsdir ]; then
> >> +        _notrun "no kernel support for y2038 sysfs switch"
> >> +    fi
> >
> > This will always fail, so either the kernel functionality gets merged=
 or
> > the test dropped. Can you let us know the status? Thanks.
>=20
> I=E2=80=99m posting a more comprehensive kernel series (~35 patches) fo=
r this
> in a week or so. This test was requested as a prerequisite to merge
> the series:
> https://lists.linaro.org/pipermail/y2038/2016-November/001981.html
> There have been 5 versions of patches posted since then. It has been a
> little difficult to get these reviewed.

Ok, understood.

> The series makes more sense now anyway as we finally have 64 bit
> timestamps for vfs.
> If the test is a precondition, then we should still keep it?

Yeah, in that case keep it. The kernel patches are on the way to
mainline and strftime("%Y") is still less then 2038. Thanks.
