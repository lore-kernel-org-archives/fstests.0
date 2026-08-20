Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E3D37B3E4
	for <fstests@vger.kernel.org>; Thu, 20 Aug 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237881; cv=none; b=Mj9xxirYsBPdFR36MAvF2t5HS4miPD6GxlP19o5ncfFxiz+v2U55gGB4IHK7rmcBzIEBtUT7jGwklvd9ZEvSwq0Lg3Y/m14xb6sZGban6LdcqEieVFITl05o3h3hP+QwBfTdWJ0UERNhyS8Fk7YbnWN96MfI49j8Ko6OobGFDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237881; c=relaxed/simple;
	bh=qZKXxy0bJtL9HwoDLMITpVCgbGMEoWBbsA+RM/oCcN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AE/9u1XclTWm4FU1cWoBu6bLHhsIcE0RP0TYiWa8oLD+zh3LnlXfDOu0VaYGBTtU28IVVseHMqOjtLWQgwOx0haXfmSx8YRPlFLnTxvNgobWReIuhD+ogsB/f1M56uGyE37aGGWbdrXgVLehtIc3O6HGNu8vvzqUe8jUnlzEW+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=TxFw5EVO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJR3Z0JU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="TxFw5EVO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fJR3Z0JU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0EA62EC01C3
	for <fstests@vger.kernel.org>; Thu, 20 Aug 2026 10:57:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 20 Aug 2026 10:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787237877;
	 x=1787324277; bh=j26YQn4eYtsqvqgqllLLC6sy5bse2mP0kFPvgjM8ADU=; b=
	TxFw5EVOcrBVQWWdl7knQQ9eQ7BdlcY5mKqMC6tiF6lZRSUf7mqC4AWb3JBBuMRb
	ET/gFiomthVpOS++PsxrK1RP00T75XcDkdVBvN0r3cikNOjG0F1pCf3QlavKtVvm
	NN0zsVaCiiyCzs5EB1vMt88uR0cFBrQTu6Qpo0aqizpRK5gRWmQuTPRJ2fmpQtet
	50MRFUozBdvMARLqHxeyRIS4801g/kDQnoTy5u9+3rRMA2zkrE+T8TTHjvi84eEA
	mty5obayAsPYUtjGHrt6rBFwdNQp8q9lXyU+DyI1tkxEGqAW++/fn8RaNHzAxx/E
	lO8b4JY8bGN5kxyKrI2Vcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787237877; x=1787324277; bh=j
	26YQn4eYtsqvqgqllLLC6sy5bse2mP0kFPvgjM8ADU=; b=fJR3Z0JUFD+0LqhPq
	wGeKBgYvkuPlDwaNqpF4IMx7J3C9ORzjEul+ojk0ydx3LXuzsWj3fUYTaMhQgcLf
	5pvvH3buOxSBbTDHepkTkLvn3ijV3h11liha+KOn5NiVjnBJGZ+s354pdhgwKkp+
	QR9c6ZKuNmOBVqH0q93z99UH3Sx7k/F9r+GNfRcMnMx+2/jS/k9TVDLog/wrMubd
	UpDvzyBAD8dH4HyJYM4ZMROiqQf7i2p2t0mnYI8iRyqA6jXhsJcO7ntEjqs+npKo
	mr+4hJ/TahDsumh1UC9tSB6GaUAdUmvJJPPjU4CDkb+8TeNrtU6KNA4ymmGnkLHh
	lEU6w==
X-ME-Sender: <xms:9BWHatVi4pk0gKG6r2vnfvurrBt4rRRZESFbFsZ9eTuuE1e-UVLokQ>
    <xme:9BWHakiHK2NamGZXHf6FwxQRnM3DVxaHZGPhovVTRGaAR8EnIpZYJJU9y9z7SslYw
    nE5SuEUInOWeianEPVOvTDGpMajkNhUXhduf85qwfmJIk82ZDO3GibS>
X-ME-Received: <xmr:9BWHavC0lffkUpTiyHW-RXYP8cnNNVsbFaxvSIcIW4eA7JIURP_kMnESQyHY36hxisfg4fL_z4s9qelSmMFSi58V>
X-ME-Proxy-Cause: dmFkZTGsPLYePC5uzzxa0nKM1rNgQE4DGf5SpOkwc2DZTwVqtb2zvDFJ1ag43SEo75G8yI
    vMir6TNpg2hhNPhT7v86ARiBut1VbkvMwvQ/QgoR651NnvgkuXA1McSVjbNbxo+V7PzxQT
    M0fbw7izkh6j6Jo0KFwKQgxQFv4TNT89BwgdtHWFcq1//XSYfgC6nkrjXKrnsteOuW1Pma
    +JeU8etY48HoZw+7H3Y/ewnGwSkSxCKVJq+ZLeyyBvnbTzUy35k0U5+kdZzPmELy1Uvt3Y
    x5LCXxgKNZo/eufR1g8akiMasMwxcuZtg+6fWzmP5ghWXdbzh/8nv3w2yjnHyywXrDl5Qu
    0quZlRju4Yr+DMHLckpQIr6Aq9XwMe5o0l2EWybc5BygSsyzsKOErP7NBnbi9pCeF4n5WA
    3Cmb/Vx/bPoYWA5zeFxqBKgeYliLxe60+bqrGEDTU2ttI63WkAYO2zTWoSQoFOENq0HB0O
    U3coLb65KsrM4vOaS3TBDxMdKcoKdVyCyWlrVQTdvVgkldd15RuGsYgqkZCdjxml8/N504
    mEYhCs/FihhrzneLJKOlIF6/P1gb+mi2kj1qTXOeNajArUjK3N6p5RHyghrTRo/0FnjGli
    QZlQzYfjD5GbQlKdzkSsCkEniUnS09uAKY9yZdz3sR7TNyee7V54lHy49/FQ
X-ME-Proxy: <xmx:9BWHalcrA0H3ufH826tUFsjg2KijA4p6sRbiGJLCtKQMez9bOh6M1w>
    <xmx:9BWHaneToo57_PbGtw0UmiW4TxoNkj03e0JKnSCkJUfSZTjkxiKZ9Q>
    <xmx:9BWHapigFLHxy4Xf65coYkzBMJ5AbQtSKV7drLjuAfaJff-1WzP62g>
    <xmx:9BWHajT6L9ncsJSDh1sfenWUj03jMD2p-ML79sBgxH86LvH9ZrQM5Q>
    <xmx:9RWHaon-hC2ZMs9q1HmqT3S--hda1V4AFdk4xKqXyBkuuGqpon4vFFdK>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <fstests@vger.kernel.org>; Thu, 20 Aug 2026 10:57:56 -0400 (EDT)
Message-ID: <3801889e-b173-4971-bb84-11f5e3434705@sandeen.net>
Date: Thu, 20 Aug 2026 09:57:56 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/683: _require_chmod
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <a6e9a97f-295b-4bba-aaef-60af17e9c70a@sandeen.net>
 <aocNwfDmKV4DB9M5@zlang-mailbox>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <aocNwfDmKV4DB9M5@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/26 9:37 AM, Zorro Lang wrote:
> On Wed, Aug 19, 2026 at 03:32:01PM -0500, Eric Sandeen wrote:
>> generic/683 uses chmod but does not _require_chmod, so filesystems
>> like exfat fail.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
> 
> Hi Eric,
> 
> So great to see you ! This patch makes sense to me. Actually, g/683 belongs
> to the same group/patchset of SUID test cases as g/684 through g/688, and all
> of them use chmod. If we need to add _require_chmod to g/683, I would suggest
> adding it to all of them.

Ok, fair enough - I should have looked more closely, and when running exfat
all of those tests properly did a _notrun due to /other/ constraints, but
we probably should explicitly mark each requirement even if they are
stacked.

I wonder if some sort of checkpatch or linter for xfstests might be
helpful, it's pretty simple to grep a test for chmod and ensure that
it has _require_chmod for example.

... or I wonder if it would be runtime-prohibitive to just build that
into the check script; if the script contains "chmod," run _require_chmod
automatically... similar for all the other trivial _require tests.

But maybe that's trying to be too clever. :)

-Eric

> Thanks,
> Zorro
> 
>>
>> diff --git a/tests/generic/683 b/tests/generic/683
>> index 883905da..226d2758 100755
>> --- a/tests/generic/683
>> +++ b/tests/generic/683
>> @@ -24,6 +24,7 @@ _cleanup()
>>  # Modify as appropriate.
>>  _require_user
>>  _require_test
>> +_require_chmod
>>  verb=falloc
>>  _require_xfs_io_command $verb
>>  _require_congruent_file_oplen $TEST_DIR 65536
>>

