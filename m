Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D227735
	for <fstests@vger.kernel.org>; Fri,  7 Feb 2025 01:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738890566; cv=none; b=O+ll3K/l3QQifxCE66FjdccCdsYRef9kvZ5oLrG+qIFiEhLmBeFWKbffRNwJ5yCIoERABaSjl7Flud/ac0S733/S8lyMIefC/pkVfI6p915CRYIV22LJWNGI6R+FMx/xHt+QgoNN1sYDhHFB1jmBYVk89uXznXbRCQbhj493kgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738890566; c=relaxed/simple;
	bh=IGikku87lxhIm419Y2N+ct61Cf3lH4de10lKz1rKVXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISw9a5ePhi2Q7GE/4MpBcdO/agItpAS8k8xcLBaOesbNuIVcuLUDEgHKf1G0mwYRIf4VNGpYQ99QUgDLTH/WGrNyV6lTT7HKpv1Py18pkQ8vPjX2ZC0lfi1KFeAdjL/i67muy94pInOUHlotjW4VxBmcYR/vC+4rEm83WovQ3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=JCZoxTvw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OgYFbCoh; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="JCZoxTvw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OgYFbCoh"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F70C1140222;
	Thu,  6 Feb 2025 20:09:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 06 Feb 2025 20:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738890562;
	 x=1738976962; bh=xZm9RV/TXL6rfoSRd0RjGxOntu8AhGTU140/9qoksAs=; b=
	JCZoxTvwZWDYyywdzkZKX6bMY7JOX9U6W23GnFflA4bXcbYmJ24Q2s3Kmvdoq5zw
	9xD5SZQyBJiXIBPKKe749loCjDgjOitEM8MTKuHai++VxDsd4tUMRQ+Ih+ScCASX
	pO8ggdp5zs9xdX6Z4hKzC8fdEjPv4JWK3Q9dr+i/dAg1VGiNm6MWaMlnijDIebn8
	J1KSJuQ4BY+8yvVOAg2pebUgvcym7RqvZuWW7gVJJ9eI3siytw6L6wo5+gqpr1nw
	qEgul1DEv6Hv0uz7/Pmv0r4TbAJAI/BEjnVFkrvWGMJhLtDCnchmaXJLqEEhFeD8
	KRj3fG62GoON8TZmhajblw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738890562; x=
	1738976962; bh=xZm9RV/TXL6rfoSRd0RjGxOntu8AhGTU140/9qoksAs=; b=O
	gYFbCoh4dmU4V0rpc2mkmy0hDozxs6dQBncaDl2U4hac00Ef3xUO1lhziKHBijY1
	CYBkRvsf2LORU78uiSAtDd0gmT0b/2NlpulcJrEWORL2rga8V3uH8hc80/K+XOi1
	UuiCFnctrOvyUR5WIBW1BydP57Nq7wsg/lXdZuQmpXjNhBYWd3jGzAA/v3s6boQE
	W/XVYL5a5ONdsHRmtShjJdGV0EG+lTSYqR9jZ6Y0W6wlULN+6V3kG/ubnjkK/4rL
	BW3PjdVo9u4t4zdpeXiFtDErgv6jmsDjAQxvkVfG/Q4YXkdZb+Ey9touyhGcLFDH
	0Qll83jVEW7s/tFCOSV/w==
X-ME-Sender: <xms:Ql2lZwSHI3rqKjwkLXE1S3XkQXJwAFA4zby6DeQyA9HpHV-0p7O3HQ>
    <xme:Ql2lZ9wwFCRpJBS9MQVVydwPJA5atspcDwodYy4tPk8h3BAYGfWrmzg5lnADiHzBs
    7wWdP6rg4VwUwxDCIQ>
X-ME-Received: <xmr:Ql2lZ93NrkpV6eWmDlFZ_p3kVEUEXUuYgDjpBWpil8DQN5Y-z0IFrQGmfU7HG8UrSZy0zaS7paZXTt6DeKkYM3DUUxtv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvg
    gvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepveeikeeuteefueejtdehfeefvdegffei
    vdejjeelfffhgeegjeeutdejueelhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgrnhguvggvnhesshgrnhguvggvnhdrnhgvthdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughjfihonh
    hgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggvvghnsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ql2lZ0ChAYyNMGUhYrQjcbm79bsQKfadv5A2Uw5m-v-Syw6xgjRkgQ>
    <xmx:Ql2lZ5js1HZZ9GG1625NZOueEc_JW9GiSWKNZj9t5L2XkirsFHB6kA>
    <xmx:Ql2lZwrpP1JGjMf7faiBKW9bOwZYCOHDpfEVef_kkIqRF44NaDHezg>
    <xmx:Ql2lZ8jGamQu5PQBcpJaTNIiFuALZ-7285V0w3m5u0gJnFWv4kux4A>
    <xmx:Ql2lZ-ulFBa1-KBWLFdMOGkuFznfGmyqW0H0SHBsIPrsBNWy1z7E2i1z>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 20:09:21 -0500 (EST)
Message-ID: <006e3012-c4e9-4672-a9bb-ccb726017b21@sandeen.net>
Date: Thu, 6 Feb 2025 19:09:21 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] builddefs: define linux
To: "Darrick J. Wong" <djwong@kernel.org>, Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-3-sandeen@redhat.com>
 <20250206223905.GO21799@frogsfrogsfrogs>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250206223905.GO21799@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 4:39 PM, Darrick J. Wong wrote:
> On Thu, Feb 06, 2025 at 03:19:57PM -0600, Eric Sandeen wrote:
>> There are several #ifdef linux guards in the code, but nothing
>> defined it. This caused several sparse warnings, so define it
>> when building on linux.
> 
> cpp in gcc 12.2 defines this:
> 
> $ touch /tmp/moo.h ; cpp -dM /tmp/moo.h | grep define.linux
> #define linux 1

Huh, on my test box too.
And yet without this sparse coughs up lots of things for me:

tlibio.c:90:20: error: undefined identifier 'LIO_IO_TYPES'
tlibio.c:90:33: error: undefined identifier 'LIO_WAIT_TYPES'
tlibio.c:92:20: error: undefined identifier 'LIO_IO_TYPES'
tlibio.c:92:33: error: undefined identifier 'LIO_WAIT_TYPES'
tlibio.c:118:20: error: undefined identifier 'LIO_IO_TYPES'
tlibio.c:118:33: error: undefined identifier 'LIO_WAIT_TYPES'

because i.e.:

#ifdef linux
#define LIO_IO_TYPES            00021   /* all io types */
#endif /* linux */

make V=1 shows:

/bin/sh ../libtool --quiet --tag=CC --mode=compile gcc -g -O2 -g -O2 -DDEBUG  -I../include -DVERSION=\"1.1.1\" -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -funsigned-char -fno-strict-aliasing -Wall   -c tlibio.c

so not sure what's going on here ?


> --D
> 
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>  include/builddefs.in | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/builddefs.in b/include/builddefs.in
>> index 7274cde8..00dec0ea 100644
>> --- a/include/builddefs.in
>> +++ b/include/builddefs.in
>> @@ -78,7 +78,7 @@ HAVE_FICLONE = @have_ficlone@
>>  GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
>>  
>>  ifeq ($(PKG_PLATFORM),linux)
>> -PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
>> +PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -Dlinux $(GCCFLAGS)
>>  endif
>>  ifeq ($(PKG_PLATFORM),darwin)
>>  PCFLAGS = -traditional-cpp $(GCCFLAGS)
>> -- 
>> 2.48.0
>>
>>
> 

