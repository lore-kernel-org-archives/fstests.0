Received: from mail-pl1-f176.google.com ([209.85.214.176]:39564 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPOgq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Dec 2018 09:36:46 -0500
Received: by mail-pl1-f176.google.com with SMTP id 101so4902061pld.6
        for <fstests@vger.kernel.org>; Sun, 16 Dec 2018 06:36:46 -0800 (PST)
Message-ID: <5c1662fc.1c69fb81.b6c1e.cb65@mx.google.com>
Date: Sun, 16 Dec 2018 22:36:39 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 2c97b8691d05
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6WPgxdNYvisL"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--6WPgxdNYvisL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is one really minor update that contains only one
improvement.

Thanks,
Eryu

The new head of the master branch is commit:

2c97b8691d05 generic/062, 520: Don't remove lost+found during cleanup

New commits:

Xiao Yang (1):
      [2c97b8691d05] generic/062, 520: Don't remove lost+found during cleanup


Code Diffstat:

 tests/generic/062 | 2 +-
 tests/generic/520 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--6WPgxdNYvisL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcFmKOAAoJECZSqilcj+djP+UP/iA/sKcPk8Nz8qXl3DtWOUPW
kwkl0VKCJ80c1ZhfwW9jTw1hAhvGa1xq66XAlD8EJ21ScTi+Nh+ANMvEuVNEiGRA
LNn3Sa5NTsfTf3NgwByIckccdxCalNHhq07ViKVH04DIq+14JJG5Xg6CqfdH8zO0
9L4ohD3moMWuSCPPaNI23wZapZECm5V5YAzlV5DpUUT/zBVxTm5tuDG7iuSY9hPj
AmAmH/Fq0A6p09Z2Qy9hh/Z3/ARUNP/Vn2ivJffHjvz17xvgUUe4PTtU2fbXUnGC
RFw5eORTu48t8S5zla/MAAvX/Vxas9Ht6SGmF6lTEIoYYAoc45wgQuH8eop1gYaW
0FTBXOY2LbL/O4+Ra4MuzANzms44GzI3RKsPS7kTh0E4S+CrMpryyiyzaIB8KOrA
B8DJzIRTx9L44j6nrERX4LMZKb1kdeWAiqjy1z8zu/P9qwPPxAdTpGbyXsDyTC45
GXgNVIj7wkHmAe2hSdD2BhRChYx0Lc8T/0kUZh7nf4fgYfHljqkehJgzHHjMRCrt
PCTjaZXcbEpVhQnf30sVXCq/RB9jd+7xY5IrRNXxT8qMVh+wsMXWcX3+h9H7CWyp
d8SJibpIG2HcYS5J2IgjaNkszSnVejVdk4kUpmiJ7OFh8UKlQizIDb2uzky7k3+d
FWpYNCciXdrBG/LW9msf
=YdNn
-----END PGP SIGNATURE-----

--6WPgxdNYvisL--
