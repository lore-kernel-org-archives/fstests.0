Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9933175A7
	for <fstests@vger.kernel.org>; Fri, 15 Mar 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493901; cv=none; b=Mf1TI/vYnf3OcCoD8t4oYdK88ACJ8KG8dYlTnR4ej+dvO/IdJb7aY2e0S2ca/ywFyGF9pG3iXnXXl/K7oa0+IMsFqHfSmM9xfNXrxH+qf/vmhORIAq7qSpjHSIaGkps7r1eiVC4WeA8j1DnlEHYj9Mx9IXiCYyHM3Du4dzP6f+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493901; c=relaxed/simple;
	bh=lFZCn49sMqJCz9SZnwJE7NueXlof5RP+5WNsH5qxShQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PZJcgZPr4l52ngYChATcArFHowVB2buNQgpJtsOklF0tvL2+xswNhCkyUwcL3IwZItvGf2YKNGRaXiGiBPTcqegHebSthG7YJNUud4b5uyeKXsLz0D0+N+tuJQGMVMgKtX4jkC1nKFRdSiS/FjF4Ed4KcPZQmZYOwzkI2mwHdC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lcl7BDe8; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lcl7BDe8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710493896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mFk5EVQvJ2I2qTwXChwpfTXZZ/uyJjyjgQbKBAwd/F4=;
	b=lcl7BDe8EXjpDA9joWjQ0DsaZMNPFIqLhtnpwN4iycybf6eAfUTf2rypJ2tyJ1uJzcu0vR
	frWXdM+PpL7nra8u21LK+Zos3xDEXYkHYsl9AZ3Z6HuyX0o2hV+fXggtDAK4d7k1u0XlCo
	fmCJA8zr9/PUw1vMKU+VNtsQ9fvuO3Y=
From: Luis Henriques <luis.henriques@linux.dev>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4/006: take into account updates to
 _scratch_fuzz_modify()
In-Reply-To: <20240315025138.GG6188@frogsfrogsfrogs> (Darrick J. Wong's
	message of "Thu, 14 Mar 2024 19:51:38 -0700")
References: <20240314172512.28293-1-luis.henriques@linux.dev>
	<20240314172512.28293-3-luis.henriques@linux.dev>
	<20240315025138.GG6188@frogsfrogsfrogs>
Date: Fri, 15 Mar 2024 09:11:32 +0000
Message-ID: <87le6j7tbv.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Thu, Mar 14, 2024 at 05:25:12PM +0000, Luis Henriques (SUSE) wrote:
>> Since function _scratch_fuzz_modify() has been updated, its output has
>> changed.  Modify test ext4/006 to take this change into account.
>
> Now that you've blocked off the XFS stuff, what line changed?

Well, there are three lines that are gone with commit 9bab148bb3c7:

	echo "+++ touch ${nr} files"
	echo "+++ create files"
	echo "+++ remove files"

And a new one was added:

	echo "+++ stressing filesystem"

However, running fsstress will also add a new line with:

	printf("seed =3D %ld\n", seed);

So the delta is one line (seven instead of eight).

Cheers,
--=20
Lu=C3=ADs

>
> --D
>
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>> ---
>>  tests/ext4/006 | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/tests/ext4/006 b/tests/ext4/006
>> index 8792167bd9c2..b73692aa5b81 100755
>> --- a/tests/ext4/006
>> +++ b/tests/ext4/006
>> @@ -131,7 +131,7 @@ echo "++ check fs (2)" >> $seqres.full
>>  _check_scratch_fs >> $seqres.full 2>&1
>>=20=20
>>  grep -E -q '(did not fix|makes no progress)' $seqres.full && echo "e2fs=
ck failed" | tee -a $seqres.full
>> -if [ "$(wc -l < "$ROUND2_LOG")" -ne 8 ]; then
>> +if [ "$(wc -l < "$ROUND2_LOG")" -ne 7 ]; then
>>  	echo "e2fsck did not fix everything" | tee -a $seqres.full
>>  fi
>>  echo "finished fuzzing" | tee -a "$seqres.full"
>>=20
