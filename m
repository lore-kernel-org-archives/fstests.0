Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E51B6D1B
	for <fstests@vger.kernel.org>; Mon,  4 Nov 2024 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730760259; cv=none; b=Ze6s37NG7J5fKrTa3BdIVI08WPgMz9pmVRcRuFnjpTwXiLj4LTZM8NOSrdknAxVdhI2xKK+O9f6PPHrxzbBskL66Puqv99b7YxMgODO9G+N5hDl/QPX6kl6bzhomsREbrY9u5c5cjJI/R8GiUWAVmvhTALHB2Mi/Z8tNNUc0zKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730760259; c=relaxed/simple;
	bh=gOOYAh14vQVdWAi7fpFIXaV1JAE7T9TcVnN9swtkP+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MJq8BGYGF3mUWt6vwOvr9K8dMoynjak9oH99mGbo7G5OQxAONQ3pTCoIclq6hatxKHyJc06GA3jfhMH55fub+uS5n5JvJ6AKr+H4FBJ3VmW6DIsCUxBahnp1ktj4hOZk7ZXIBXjcOsLdDnyZ3zonyWJmH96yCwsu/lcN63y7uLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=cSBKBVDq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="cSBKBVDq"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AEC9EFF802;
	Mon,  4 Nov 2024 22:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1730760248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0YHT7XEnvSHF2h0Gvj8SNKebpldOIqmtiWs42euKE8=;
	b=cSBKBVDqke+4/tetViOEwx+WjUWX0Y12nkn8ojx7HhT8CBNr+R5l0p/YRjcyGvg/UEYcTD
	wASlyJqf7SlvlETROZlp4WVthmWLhtT2dIpzaO0yVyGCdjvX9wKGQ+brEKDnLdm6xrViBF
	KgMRiMrH7Da2uKFeiyRhmDRjSczv2Kt/pJGROtjyZGA4y9RqrGp2B19DywAZArkV5K3Fiy
	p4YbRfGPMPti36dHELV1WsnDN6rlTHg+D11AqvqrbIeCzWOlRHZeZ9LDcZPUsi/RBJYskm
	a0fPYc6PawDHZE9uVNkoy4Or8Wdjul2RvW+DzpRbpb34R33soqNOdqDQJcVBfw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: fstests@vger.kernel.org,  Zorro Lang <zlang@kernel.org>,
  kernel-dev@igalia.com,  Miklos Szeredi <mszeredi@redhat.com>,  Eryu Guan
 <guaneryu@gmail.com>,  "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] common/casefold: Support for tmpfs casefold test
In-Reply-To: <febd4cb4-9802-4181-b591-b9978829e493@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Mon, 4 Nov 2024 19:12:18 -0300")
References: <20241104210636.38934-1-andrealmeid@igalia.com>
	<875xp265by.fsf@mailhost.krisman.be>
	<febd4cb4-9802-4181-b591-b9978829e493@igalia.com>
Date: Mon, 04 Nov 2024 17:44:03 -0500
Message-ID: <871pzq62mk.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Em 04/11/2024 18:45, Gabriel Krisman Bertazi escreveu:
>> Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:
>>=20
>>> @@ -67,6 +74,10 @@ _scratch_mkfs_casefold_strict()
>>>   	f2fs)
>>>   		_scratch_mkfs -C utf8:strict
>>>   		;;
>>> +	tmpfs)
>>> +		# there's no mkfs for tmpfs, so we just mount it
>>> +		mount -t tmpfs -o casefold,strict_encoding tmpfs $SCRATCH_MNT
>>> +		;;
>> This looks like a hack.  Why mount it here instead of _scratch_mount?
>> This should just be a nop for tmpfs.
>>=20
>
> _scratch_mount doesn't have any code related to casefold, should I
> create a _scratch_mount_casefold for tmpfs?
>

Yep. That's what I'm suggesting at:

>>   can you fix _scratch_mount to correctly mount casefolded tmpfs?  if
>> not, provide a new local handler that will either call _scratch_mount
>> directly for !tmpfs or do the correct mount for tmpfs.

>>> +
>>> +if [ "$FSTYP" =3D=3D "tmpfs" ]; then
>>> +	_check_dmesg_for \
>>> +		"tmpfs: Using encoding" || \
>>> +		_fail "Could not mount with encoding: utf8"
>>> +else
>>> +	_check_dmesg_for \
>>> +		"\(${sdev}\): Using encoding defined by superblock: utf8" || \
>>> +		_fail "Could not mount with encoding: utf8"
>>> +fi
>> Ugh. the kernel message should have been the same. Much better
>> than special casing the test.
>>=20
>
> Well, to be accurate the encoding isn't defined by the superblock in the
> case of tmpfs, so the message would be imprecise.
>
> But I think the if wasn't needed after all, the _check_dmesg_for grep
> should be able to do fine like this:
>
> "\(${sdev}\): Using encoding" || \
> 	_fail "Could not mount with encoding: utf8"

that's better :)


--=20
Gabriel Krisman Bertazi
