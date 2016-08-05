Received: from smtp.nue.novell.com ([195.135.221.5]:49399 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934069AbcHEJrM (ORCPT
	<rfc822;groupwise-fstests@vger.kernel.org:0:0>);
	Fri, 5 Aug 2016 05:47:12 -0400
Date: Fri, 5 Aug 2016 11:46:40 +0200
From: =?UTF-8?B?QXVyw6lsaWVu?= Aptel <aaptel@suse.com>
Subject: Re: [PATCH] Create test groups for cifs in xfstests
Message-ID: <20160805114640.1051cf07@aaptelpc>
In-Reply-To: <CAH2r5muHTHXikTCqiiU7AFx8Z-Ra_7CYK4f6PCZ_4KfVbO3-PA@mail.gmail.com>
References: <CAH2r5muHTHXikTCqiiU7AFx8Z-Ra_7CYK4f6PCZ_4KfVbO3-PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/6gEaQZS=AmHMKs9wIOko5Q1"; protocol="application/pgp-signature"
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: fstests@vger.kernel.org, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

--Sig_/6gEaQZS=AmHMKs9wIOko5Q1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Apr 2016 22:53:15 -0500 Steve French <smfrench@gmail.com>
wrote:
> Attached is a trivial patch to create two xfstest groups for cifs

This is great! I remember trying it unsucessfully on cifs last year
where I had test that would just run forever and never return. I
will try again soon with your patch.

--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstra=C3=9Fe 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton, HRB 21284 (AG
N=C3=BCrnberg)

--Sig_/6gEaQZS=AmHMKs9wIOko5Q1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXpGCCAAoJEDIGO5Hchq/8kOQP/0yGduVOs/tf3/uv8yJeEr6s
ImVDLDtuTomfdL30ZZzL56bJiqQtIyhEnFqzbG9Z4OFnjLzcjYerPXbMJ0TVSDq8
wyc8vWRKQT8m+TZHXOS8r74gl0rq0oh/+s0+uNOoGtynAU9fh11UmeibSGfii/zz
apEr819KlpH1rHDVGjKce5VsxoO3EPxZYIvzCEopBmfvNqTlaFwXrWHjcQgMbWU5
GsW9bVPHVsjY7fn5Vp+kFk0u7pNQyBpz5/A3yja06zAt7f0sPOEqpFzHxPP9xBJT
fDBxIKD2EPjT0FZKeh4ZmyB8x4nZQnyauEk1cpuqgQj060me12m+BEeHIDDLG86L
AoTfCPO7SSFa8GZcuVXJvu1izPvEshIdqE2F2C/DAKN8fBv89MepCPDnSQdzfUcf
8g62GAY+a96I3xJ+es33BPk2mqqUtWHrBPkTFUxJokVKjWKnEYChcgWD/wKA8jZQ
xtx0WqWVz+673mTGZcfWIwgfvHgi7xaIQI8J5vzlMKVRtSVzsCd9X5J6yIt4jvzd
PZeqllSwrOTQk3Eb/UuXv+v02qNmlNjUWh1CyVNb0njAzo0/eTeeaQhK0UB7X5c2
aUdQSBr8ZCEgk6vciyTniZ3j19dVjjDDLadrsNMasEMihD+NQmvfOIWJf4eh/uIs
T7n09iey7BNMP0MlZju+
=FrU2
-----END PGP SIGNATURE-----

--Sig_/6gEaQZS=AmHMKs9wIOko5Q1--
