Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:13733 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751284AbcHQDYm (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 16 Aug 2016 23:24:42 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1bZr4i-0006Iy-QG
	for fstests@vger.kernel.org; Wed, 17 Aug 2016 12:59:28 +1000
Date: Wed, 17 Aug 2016 12:59:28 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE, IMPORTANT] oss.sgi.com git repository shutdown
Message-ID: <20160817025928.GH19025@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

Sorry for the shouty title, but if you don't read this then things
might break unexpectedly for you. We've been given the heads up that
the future of the oss.sgi.com infrastructure is in doubt, so we're
taking steps to make sure everyone using xfstests moves off it
before it disappears into a bit bucket somewhere and we get lots of
questions about it.

As a result, I will no longer be pushing new commits to this
repository. Instead, I've just pushed a commit to the oss.sgi.com
xfstests repository that will not appear in the repository on
kernel.org.  This commit essentially breaks xfstests in several
different ways - any attempt to run check, make, install, etc will
result in a message such as:

$ ./check
The repository at oss.sgi.com is no longer used.
Please change your sources to point at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

and refetch the your master branch.
$

If you see this message, the action you need to take should be
pretty obvious. That is, update the origin of your repositories to
point to:

git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

and force update your master branch to get rid of the "break it all"
commit that was pulled from oss.sgi.com.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXs9MQAAoJEK3oKUf0dfodnlYP/jDRuz7v8PlJ6irOZpqJ/o3j
pak5p6PV0Gvc4ZI/a9Zlb4QrNyaKKK+B3QICp8ElNMBWAE2B/BDAdptYDPZG0XDn
uYU554PBwaNsNqw4wqRb0VputmZL+qfNS0947U/TAzmmod3c2icjnPXQ17G7si3t
RQPjH82n7XCYvnLM0aTUZ3+R35yxMs8w4UU4IamDczyso5NuUY8qYEYoWtCxpO/I
PjX4syXWulqQnSpQ8lkD9de1agGXfc6dm+WbKWsg6zAl1Xp1qd86QpDcY7WuEMZ7
nNjfJ7OlAUINBZgG90qFaLb8sJpXlfjMi8q8rn3lg8OMHOAgPI3CxaU57zQMyfT3
o+YqriJyQzS3CetfS41SqtmIHKlpwTs26tLZvh5hMQNCETQCWzAK6vrstrZ8aP0o
MF+Ntmn6rK6vdtF/Qm9+MezsSVPaSKw2D5RWmkfdpGrkTUeoL9NlUcOlwFHavEut
c5495CJMFGSiTzhSRWnRCp2DJPakFQ95H4BfqulgIbaGm/8iv1HPlFXyVY9yW1+P
nYda4vLT/mL8qv2ZIAt42GpNie5Q3betceKm7efFsiREG31uvVpwMqa/QLUxhYi0
VCgjZskPzZBla73XZ/qLHhqS0kCb+hRjtEyd5Tuag7t89rFS+kAEg8YG3tXckunl
ojFN5zKHfNSGgQfKj+qV
=ECuG
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
