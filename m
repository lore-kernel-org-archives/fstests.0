Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785A154C12
	for <fstests@vger.kernel.org>; Sat,  8 Feb 2025 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738986210; cv=none; b=GNWMDFxD1Ha37358Ya4dPeqY8rv9l0vE8g/0wTwt9r0IE4XFKTbAwIlkmYveko+hupAvh7Wa+Z+o9MdAvVRY8+9lorbowsAE75RekNG3yACK+OWtlLSnP19rXgS7Iwwvf4scLnpvLfxqfVoKh4R80r1gaqCL8/QvTWmdRiDAE2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738986210; c=relaxed/simple;
	bh=aE7D7O98jBYNp0D5jHWY7yGVaJHsXe9ph3ZVxocQ9XI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=PGl7Crnsjq4kLB2M3s2Ds2c+s01E4uJUIHe+RfgS7n8TIFXBbNoCAWgCR9MmAMDkIRdBa4XbGAZ1gDbfDJFEvD9drGJLea8szJbGcyejzyOVN/PpDzMX6fY/X7CXYVlhR3Xuv64qqA5+cIW06FtHtIuh5V+pd8kn4wjoFrhlYjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jipjNSxA; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jipjNSxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738986206; x=1739591006; i=quwenruo.btrfs@gmx.com;
	bh=N4w+RHIG+VDU702AOexlTp55/PItqvvlVA0o7c79N00=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jipjNSxAi0RgVUIq/gyLkCWjgKVgVjn337QYSDdBaVm4GB5ZkiZjFk8zGXjap89f
	 YTwpUDiO0j5IjVqbYVOmTcobBaa8CjY+FdER1mtAWbv5J/0MB63RavsiF8Y0nq4oV
	 spu0z+kljteYfty1vRN6M6SVcw5moxeeb1F2MtMlx0PFVpIpNljkvrqEFZ4hud0En
	 7/B2nL9mqCatP5RIwwH4pXPqRGFkkeoZYhuK9zpSlePpI1gyuitveNjW7fIs/fr8m
	 E4o/bsbxfRzImUOzu25Hg5ue8KTbG2Pz60wPqSGcLK5kkAYQw8opESpv/kZ6CsctM
	 F1TrxAEizHVuqfyp6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw7f-1syEOM2L1X-00b69h; Sat, 08
 Feb 2025 04:43:26 +0100
Message-ID: <b7149d6f-2c1b-4c51-ac0c-0b2d7560330c@gmx.com>
Date: Sat, 8 Feb 2025 14:13:23 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Failed to compile due to missing <linux/blkdev.h> header with
 liburing-2.9?
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9wHIR7H9MvtKNVmI4kBZ589NPyPuPt8eKzwD5UXTn33gujauYb4
 fE0AhN1WeC8eAyBS7PpzmtTEBwy5UTtIEfeMVWErgHpRazC43Jf3vQWR6HNem94yVPiRpaL
 BiQugWe9XooEV+tJDMsrOJ+dzrzr9MmN4EJmZEJmUPWB8JCcDCk50sPEC2x6PvOotAhp4ZU
 T/237wBp+uWLfj8pi5lYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fjlpWxQ3nIw=;O7PqRqh2471pfa+S4Fmqx+F8tjA
 0Fg338RBwMu+d+gEeRNSdIunlnFU/TPIVCTqIMmf7r0aO9R2EqRz4I8G43w3Fcjtx4tdOn7c2
 63pMU3lyZYg5HliLqfMdys8Id7zIqyghfxpYDCR6O9pOxqMt9q4n/i8mxIj4tunPFJAbs+FAS
 uIZaZ/Jnucegq7x10IBvXEGxZ/Mbatwpv2D8FItRaCrnGuSVhE5C8T2NtoLIAI3XqdSUbKHid
 +6uU8XrW88a5Wr1ikmUC2qyI8WykvnJeUG2FONLwke1PmsgeTkVtGvxNO7ycSBpe8q+8X5rvk
 y0o4Fv5R1dOqAAaGibgQpFLfT2LnnvJaisRV5Sxcj9BMXOf0IOsvK4ofsbRmtzlUdMIYjG9S6
 KdtQyuMNy7L1oOhJ9BADskxBT5qzmGyFqWYyIyHulgl3/C3Tau6KeJHD+R7pDr/MSoquNx4c9
 0vUUxsujpk3ShAnj05KZEIK73pIyFpCgHICKbiNDiGzBmEa9yDmbBZMJmzMNLsJTrZQ0tIwob
 UYLf7AWBb+613a2aGdXY1CiZMpRCic0CVUDZKapBkWo6bZLwa/Zy2edZ1gDTnbrteSG0MAT1D
 +PJ19JKqSg10Cqi4mfPaYYjhPDZ2nywMMtqTFPRxkScHH0Vx2bV38Ez2Zupbg50mvY2AVRpPb
 cTCqRmtw5JQbxEqAN/Qt7q+Nxpju5nM7IdyRj7KD0Y3hWHbrIsv54TEVplWRVeZ7fq+3FkPT3
 hyBsFB0IBBBNWIfWG01eiX9eObOCJLqq7+ZnrRWvhqvphuahTZcwwPsa0FJv8QAIhSa0EWPH1
 Tzg6431z9+Fd9AGsHZRkMyDuGfBr2J3n3tfk9VS+dXQYDEcj/YwD+doJAFOF88PLTp/ZnVeux
 89dK/O9+hIwPysJZf/SWamV2HwEJZX7OwtaibF2Grkxqrc6nDd0pQ8lZBW29T2DIMOZSdUGdo
 Hz9lqZHyvWFto7Bt6qyHT864wo7NGcUYL7D34dIjkbbCGlfX/B5JU4fWOT/LCWckwq4L1aINV
 RuGOGkMvJ3SRDz3/OUfYepMQiqXOzcTpYplK6O+NCydXOZb6KIWrYoSVJy4J1gAkBbioq/slK
 zZqRY7NJLOoHZimXDsKtg17z9YgOr7BI2Gxzd3yVXI9SBeFns5M6m6wmOAC0xfivLrR2BPvDh
 Ykq5YrfvMP2GyOupgSNiITW5oqV+pRtyEZPpHSkXIgOjuVg/XFNZLluHV/8Zy5mZhYzLhInUU
 afTDb7MkDhlkLhfahw5przr1ObkCB1zCj9v0G5PJpMdt1l284hZCl+kRLr2l0kp9rMuVgUGkM
 8D248THrO+ukU8yj98TH+cF+mbxlxSCs8e7aXNYC0n0Dgy1LKrR6yGOPWhL0ez3tfZmNhnaGT
 NyL/j2EtKyjMNqig5cAy9wdpe+wmaOvUwcB3TeUGF72BWg/v3ZOEKzNdg1

Hi,

Just find out that fsstress no longer compiles on for-next (v2025.02.02)
, patches-in-queue (a494849fb48dc6b276c2a1784d6ff66c731e5572) nor master
branchs (8467552f09e1672a02712653b532a84bd46ea10e)
All fails with the following error:

```
Building ltp
     [CC]    fsstress
In file included from /usr/include/liburing.h:17,
                  from fsstress.c:30:
/usr/include/liburing/compat.h:11:10: fatal error: linux/blkdev.h: No
such file or directory
    11 | #include <linux/blkdev.h>
       |          ^~~~~~~~~~~~~~~~
```

This seems to be a change in the liburing headers, as v2.8 still
compiles fine.

Is there something wrong with header change?

Thanks,
Qu
