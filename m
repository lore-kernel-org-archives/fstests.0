Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:50697 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728075AbfACV4N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Jan 2019 16:56:13 -0500
Date: Fri, 4 Jan 2019 08:56:09 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/config: Always create RESULT_BASE
Message-ID: <20190103215609.GU6311@dastard>
References: <20190103100135.24748-1-nborisov@suse.com>
 <d8faa1f5-87db-b029-4e68-68d76f7c410a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8faa1f5-87db-b029-4e68-68d76f7c410a@suse.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 03, 2019 at 02:29:08PM +0200, Nikolay Borisov wrote:
>=20
>=20
> On 3.01.19 =D0=B3. 12:01 =D1=87., Nikolay Borisov wrote:
> > Commit 7fc034868d5d ("common/config: create $RESULT_BASE before dumpi=
ng kmemleak leaks")
> > inadvertently broke $RESULT_BASE dir creation since it changed the lo=
gic
> > to only create the directory only if this variable is not explicitly =
set
> > by the user. Fix this by ensuring RESULT_BASE is always created.
> >=20
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>=20
> Eryu,
>=20
> I think Johannes' commit should actually be reverted. Currently
> get_next_config is called at the beginning of the section code _AFTER_
> _init_kmemleak so it's not really fixing the problem that Johannes
> described. So care to revert his commit ?

Yes, the original commit should be reverted. Using RESULT_BASE in
the way that init_kmemleak is using it is fundamentally broken.
Using RESULTS_BASE is incorrect - harness run state is supposed to
be stored in the section-aware RESULTS_DIR (e.g. see
_require_scratch()) which is constant and always exists for each
section that is run.

The code was architectected this way because section definitions can
change RESULT_BASE, and that means the RESULT_BASE defined when
init_kmemleak() is called may not point to the same location as when
check_memleak() is called. Hence check_memleak will never run if a
section definition changes RESULT_BASE.

IOWs, the init_kmemleak() call needs to be done inside the
section iteration loop, after the section config has been parsed and
we've determined if the the section will be run. This is where the
original code created RESULT_BASE if it didn't exist. Further, all
the section run state is then stored in RESULTS_DIR, which is
created from the current RESULT_BASE (e.g. see _require_scratch,
check_dmesg, etc).

Hence init_kmemleak() and check_kmemleak() should have a scope
inside a valid RESULT_DIR path. And once this is done, you can then
add a USE_KMEMLEAK section variable to turn kmemleak detection on
and off via the config file on a per-section basis.....

So, IMO, the correct thing to do here is revert the original broken
change and fix the kmemleak infrastructure to be properly aware of
config sections.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
