Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE91F94D
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700694; cv=none; b=GwUxil0N2r9tse4R5MXvUosw/shaptiSC+eOXnP4t+/pe1XfNtdGckDiE/kNVHQzoQIinqNmUdxRniD2QDkPSjpcUPiKbjs7yd2l6qop10P2NMC3h2WYbgGPHYkVEwFs+I9ZM6Jl7H8jSk3UTmpN95uZZSDWqGDKyokjcFUT+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700694; c=relaxed/simple;
	bh=xS81FVcuHxiqkviWoJTwoh8W9UwSi3N1aDfe/VLfwgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gc9zwkqT5Ar2rXwE8ZfSqlCwXljg/RpAICwyJp2cNeAajAqOROXaYY/yFdV9LExU052YSRNmQ4pn3cgRIbN0TmKlcDreTFnZE3Gp2fPJaPcStABfgLSYz2okhEtSkxkqrp50u0T5JxHXk64/geu4zvTcVVDFytwn5kWQnEXpGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=mLe4XCnV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=8XqMOA1h; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="mLe4XCnV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8XqMOA1h"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 893B925400E9;
	Tue, 11 Mar 2025 09:44:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 11 Mar 2025 09:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741700691;
	 x=1741787091; bh=QrCF/r5/MMIWHY4+ZCzQNjd7heT7qKueU8ssf/Fb+3k=; b=
	mLe4XCnVAo5oXdlvUEN/1sVcm2dVqmC7cK+SJGVzqAM7Wp+nYUgR64gYU1a3PGBC
	HhDtyizgQH1sV+uh+S1n5IZO299gr08clVIIuiVIPbekYuDRB0R4FHcKuxLlo3Vh
	trUQe9JsnV+PU9oEvQvkAdOorUaL3vvuw+ocz5jnYcBJEJnU4FaSp9SPU/JH94j8
	69G45FxeXkh/42GtZ7TXDl93WsoqRnTR9IC+Z3CSh2bVZW2TqZqFcvm6fM5V9ker
	E5OdMS1AV6n1/tHD0Te5kO34V4y09GaDoIfYj7xQlM9jRi3fVZ63gLMRetMiXmBv
	AU2XqTLGcDkSCUnxWb3iXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741700691; x=
	1741787091; bh=QrCF/r5/MMIWHY4+ZCzQNjd7heT7qKueU8ssf/Fb+3k=; b=8
	XqMOA1hYOQVe8g10B0EKNPODceO2esWFFEl2XhABNnxyMu4Gisx3famwBB8D7SXw
	5RQT+k9JrDs4rDzhItBapzFSRT/AG/IgCnquCB1cptXZtWYwayN5vivYenInN4BH
	KnAZ/7VKvqmo/qDGi2BV8x9Y/ZFlo1tz+VmtCui1RKiwiJYbfCWJ004ihfzISrjS
	/E2lNUWyT49gnQcMGYQF0sL5Qx8xcuoGWB2ReW1gM44U6l/+AKsX0MN+HvW//870
	Ojjrr5MM8vIKZ0GquJjuQDMPjzcp384+jow6oXQI79NuxKjxYwIJ1XbAw5ShDLgU
	hvEq4lBWUJjbnVH6vwAhg==
X-ME-Sender: <xms:Uz7QZ8sU0KfqQIiBfgrgifzNqWum-UyKZkhO6oNBISWkltnaBgmPvw>
    <xme:Uz7QZ5dYYePI3XhYShwFh9v49Nmxv7631rqYqQdAlLK4TCZKfaatrMCalCpHVGhL2
    KN_vzbbc-v9hJy7J9Q>
X-ME-Received: <xmr:Uz7QZ3y6ntoM1_FR6BqSeNF94ldH9xKIGbqeFKZYWgVKZEd11TObDeFYx_4rTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnug
    gvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeff
    iedvjeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhtghhse
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshgrnhguvggvnhesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepfhhsthgvshhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Uz7QZ_M6VGh-U4WPNp7jvYIuMmHQk59D_CpVzfMBhxM1deqZWTpfGA>
    <xmx:Uz7QZ88vG2ceR6z6ZUSnnPRR5BjxxmoGYpxf48gHG-6VurwFZQ34gQ>
    <xmx:Uz7QZ3XxQWl-XZKULhwb3LjA5rSFFwrh2Ro6WNrzwENPck9jxrwP6Q>
    <xmx:Uz7QZ1d-fJBs1Q6feTKdCL_Ud5FaqLDO7TzVktMaBXUd54t9IqwIOw>
    <xmx:Uz7QZwbhCJOvOA_mdfJ01KAS9Mev-DHbbab9u8HvigSoruf3HgGu16gX>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 09:44:50 -0400 (EDT)
Message-ID: <e87b6c1f-7ae6-4ab5-aa3e-697408d94145@sandeen.net>
Date: Tue, 11 Mar 2025 08:44:50 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] treewide: check for #ifdef __linux__ not linux
To: Christoph Hellwig <hch@infradead.org>, Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org
References: <20250310182954.1396724-1-sandeen@redhat.com>
 <20250310182954.1396724-3-sandeen@redhat.com>
 <Z8_oNXzVd_jd-on3@infradead.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <Z8_oNXzVd_jd-on3@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 2:37 AM, Christoph Hellwig wrote:
> On Mon, Mar 10, 2025 at 01:29:04PM -0500, Eric Sandeen wrote:
>> There are several #ifdef linux guards in the code, which caused
>> a few sparse warnings, because while gcc defines both linux
>> and __linux__, sparse defines only __linux__. So, switch our
>> guards to check for __linux__ which hch says "is the preferred
>> version these days."
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
> Sorry for nitpicking, bu "he says" is usually not a good way to
> write commit logs.  Just state that __linux__ is also pre-defined
> by sparse.
> 
> The changes themselves look good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Was an attempt to give you credit for your suggestion.

I will send V3 with a changed commit log.
