Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="IqShDLPt"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67652D1
	for <fstests@vger.kernel.org>; Thu,  7 Dec 2023 01:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701942381; x=1702547181; i=quwenruo.btrfs@gmx.com;
	bh=dM4Xi687LC3IL6PTWe9aCZVy+znP+RuwrEbj32hXH1k=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=IqShDLPtYX2oU4VbRVea7x5xZHqN5UQu2qwkgAmVWs3VObpT4s+C+PvyUKvykpsE
	 d53XM4aqwptQ65PTGqemk/ZqW6KLE02j6h9kFvQo3MgPp625jGxKbJUYFQgiE2VVT
	 Eo11Ix707cl+Zwg7EcKe0VyBtqway6ZuF2x7i9vvjH8RL2o4JTVTC4p9OETqb9e6z
	 o3HWry6w5USZwEM1UN6odsE3OQ+IuKVVu6WYLMFiNSPM1649NB5RLtT6AHuCKDTwa
	 mGnd+jMRwuXwGnz3F1Sh9GjZflYTJsuySE41Dfm7bojDoFTjmToiUpjhqSuWSwzN+
	 K2F8gY63S7DRPbgGeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MY68d-1qjUem0WGT-00YOe0; Thu, 07
 Dec 2023 10:46:21 +0100
Message-ID: <d54a526b-2ef8-4c76-8d64-352a337ca30e@gmx.com>
Date: Thu, 7 Dec 2023 20:16:16 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] btrfs/282: append scrub status output to 282.full
Content-Language: en-US
To: David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>
References: <20231207072056.14588-1-ddiss@suse.de>
 <20231207072056.14588-3-ddiss@suse.de>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20231207072056.14588-3-ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:McuEO28bzjK25Qi7W+/HgfbF1J14CIKuNT1w/+Ee4oORnuKNx8x
 VNyEo7eIbQWVCkVvn2QjWuXPEgTiKMoVI7xAnFXtu0h1f4UlJPatGvz+wiA/dLC7h0T5laD
 RL18bgAH1C/Z3UEXW6AWlqdN9cmY8wk+WWSpSM6tY58BHvKvueWTYc3HfEa/8I6m/YGqqoQ
 D81m1iwVcawOLYyrjXFHw==
UI-OutboundReport: notjunk:1;M01:P0:cXYFDMZyq68=;+1C/m7kUNdoVDfeDEom8wAKjh/6
 CDf+6tm8wRnlNcmGuPg/Q/6HVJCEMOOuNUme/jX9CAVjyYdNiv28If6fjDsoUCyNx3Xcm/XxW
 4ZlrUSr53fMAtrpdnRc/aSWYwnABOthh/yzFWCGrIBLIKxNDwBEs41BoqF4wB/PQBeiIr+Joz
 62+fM7KbqXHwLFaTFK9huDecd7oO09jEL/jBmjzDRDyRrJczTG7hICi/smE4HVqmXfIKWOgd2
 zf0UfmpQdJj+39T1lex5LhHrREKyNurox8+GLfWMC2K1UwVPfpgV9BCdBaOwi1yk/5CvgUUxv
 0BS7LcbuHYpuVGR2MSPYFENGbu1jfpAMg/P/9ulOCzUOdz/4dRK19liOVtcdEMpGOVMxQB6ef
 8fefj8aokEVlslfxxYTd5E8d3Vxn0/2rebBgnApXNOX3tm2+Po/xDypnQmK2XWhDG0m85+ldj
 Q1E+1YkGNzj2eXCuhpPYEH0G3uEjVtvDq+H8NMDbe5joDiu3b3iemHvvo6IM5fm/FYtU9m69U
 iXO8tafi07EB1iZscSOak8LIVCxwm3DBiQqjyr2vk5HHV4YjNEQhNjXlBFeN0CrpZ2pWZLGkm
 oQCOwfmc7t96Z9OUWdTOHk31F6ZNnrvcWhYhLuEFwiLcq3AmpUetrcDwzUmWN8brARuPp0zSJ
 +wUXI+bw/Qyl7OVn23O/9BLXGGgrZjV7YLbdCqrgTytuwnJ36VlKdVjYJv2XfvL1zGkjQ4rnp
 w5WHsFk0y+n1aRDmNTgg6dNQ+d+q4TZFlXlrgNQ8zn8Do9U1i4qU5SyKPPh1Ob+LI69iEl2w7
 +aFM9WaxWTfFyGV4zGSNyEPEnMz8g5lB+qRrTv3zFWumcYcUHk297TKWjwAIDZYCJiSok9mvq
 EHR3sRg7fKyVg0lTqZAKhyp+PxNK632S+POWV5Zh/taQTSxaA4/2F1vZ9W0r/YC49EDEAKBzn
 DAse4gnI7+xYLpjyhWfA42K7uKM=



On 2023/12/7 17:50, David Disseldorp wrote:
> Also, collapse the grep/cut usage into the existing awk one-liner.
>
> Signed-off-by: David Disseldorp <ddiss@suse.de>

This change itself is totally fine independent of the fix for btrfs/282.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/btrfs/282 | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tests/btrfs/282 b/tests/btrfs/282
> index 395e0626..66d14f82 100755
> --- a/tests/btrfs/282
> +++ b/tests/btrfs/282
> @@ -60,8 +60,9 @@ $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqre=
s.full
>   # Error summary:    no errors found
>   #
>   # What we care is that Rate line.
> -init_speed=3D$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT | grep =
"Rate:" |\
> -	     $AWK_PROG '{print $2}' | cut -f1 -d\/)
> +init_speed=3D$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT |\
> +	     tee -a $seqres.full |\
> +	     $AWK_PROG '$1 =3D=3D "Rate:" {sub(/\/s/, "", $2); print $2}')
>
>   # This can happen for older progs
>   if [ -z "$init_speed" ]; then
> @@ -76,8 +77,9 @@ echo "$target_speed" > "${devinfo_dir}/scrub_speed_max=
"
>
>   # The second scrub, to check the throttled speed.
>   $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full
> -speed=3D$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT | grep "Rate=
:" |\
> -	     $AWK_PROG '{print $2}' | cut -f1 -d\/)
> +speed=3D$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT |\
> +	tee -a $seqres.full |\
> +	$AWK_PROG '$1 =3D=3D "Rate:" {sub(/\/s/, "", $2); print $2}')
>
>   # We gave a +- 10% tolerance for the throttle
>   if [ "$speed" -gt "$(( $target_speed * 11 / 10 ))" -o \
