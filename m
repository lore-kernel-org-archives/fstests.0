Received: from mx2.suse.de ([195.135.220.15]:37480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729889AbfACM3M (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 3 Jan 2019 07:29:12 -0500
Subject: Re: [PATCH] common/config: Always create RESULT_BASE
References: <20190103100135.24748-1-nborisov@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <d8faa1f5-87db-b029-4e68-68d76f7c410a@suse.com>
Date: Thu, 3 Jan 2019 14:29:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190103100135.24748-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>



On 3.01.19 =D0=B3. 12:01 =D1=87., Nikolay Borisov wrote:
> Commit 7fc034868d5d ("common/config: create $RESULT_BASE before dumping=
 kmemleak leaks")
> inadvertently broke $RESULT_BASE dir creation since it changed the logi=
c
> to only create the directory only if this variable is not explicitly se=
t
> by the user. Fix this by ensuring RESULT_BASE is always created.
>=20
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Eryu,

I think Johannes' commit should actually be reverted. Currently
get_next_config is called at the beginning of the section code _AFTER_
_init_kmemleak so it's not really fixing the problem that Johannes
described. So care to revert his commit ?

> ---
>  common/config | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/common/config b/common/config
> index fb664cf0a967..e2da9cfacbb5 100644
> --- a/common/config
> +++ b/common/config
> @@ -663,11 +663,12 @@ get_next_config() {
>  	# set default RESULT_BASE
>  	if [ -z "$RESULT_BASE" ]; then
>  		export RESULT_BASE=3D"$here/results/"
> -		mkdir -p ${RESULT_BASE}
> -		if [ ! -d ${RESULT_BASE} ]; then
> -			echo "failed to create results directory $RESULT_BASE"
> -			exit 1
> -		fi
> +	fi
> +
> +	mkdir -p ${RESULT_BASE}
> +	if [ ! -d ${RESULT_BASE} ]; then
> +		echo "failed to create results directory $RESULT_BASE"
> +		exit 1
>  	fi
> =20
>  	if [ "$FSTYP" =3D=3D "tmpfs" ]; then
>=20
