Received: from sandeen.net ([63.231.237.45]:37066 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753810AbcIUBlM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 20 Sep 2016 21:41:12 -0400
Subject: Re: [PATCH 3/3] move now-generic quota tests to generic
References: <65c03ebd-ee9c-7439-2642-0362a177ec6d@redhat.com>
 <06d804f2-646e-a586-bed1-416ffde8e0e9@sandeen.net>
 <20160920234048.GB10454@dastard>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <99a7554f-9d52-510b-0631-aba25ec52b97@sandeen.net>
Date: Tue, 20 Sep 2016 20:41:09 -0500
MIME-Version: 1.0
In-Reply-To: <20160920234048.GB10454@dastard>
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 9/20/16 6:40 PM, Dave Chinner wrote:
> On Tue, Sep 20, 2016 at 05:24:59PM -0500, Eric Sandeen wrote:
>> Now that these tests have been made generic, move them into
>> the generic/ dir and update group files.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>=20
> I wonder if this would be better done simply as a tools/mvtest
> script for the maintainer to run. e.g.
>=20
> #!/bin/sh
>=20
> tools/mvtest xfs/054 generic/380
> tools/mvtest xfs/118 generic/381
> tools/mvtest xfs/138 generic/382
> tools/mvtest xfs/260 generic/383
>=20
> #EOF
>=20
> Rather than ending up with patch that won't apply because we've
> already applied another patch that added a new test that conflicts?
> Reviewing the change is also heaps easier :)

Oh, yeah.  I didn't know that script existed.

...

>>
>> N?????r??y????b?X??=C7=A7v?^?)=DE=BA{.n?+????=D7=AC?=C8=A7?=17??=DC=A8=
}???=C6=A0z?&j:+v???=07????zZ+??+zf???h???~????i???z?=1E?w?????????&?)=DF=
=A2=1Bf
>=20
> Ummm, what? That looks like some kind of corruption occurred in
> transit. There's no mailing list footer, and it's not at my end as
> it's in the archive copies, too....

Huh, strange - not sure what to make of that.  But I guess the mvtest bit
can make it not matter.  ;)

Honestly I don't care where they land, and I don't know what else is in f=
light;
maybe patch 3 should be "please move these to generic as you see fit?" :)

-Eric
