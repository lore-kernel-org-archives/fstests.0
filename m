Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869634BA24
	for <fstests@vger.kernel.org>; Sat, 11 Oct 2025 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760166910; cv=none; b=FtS64gZ5alkY2gjmqS89zBGPo9ZpX4RyWvzZ9rwujE6Elm4li+KsEbCgebk8lMZyLmzu8D75TZ0zwHufTjNTKObVVfQAyM7h87ysx9uqWHKIqpxVg1XPsqPgBqFMJKv/5bjNmbT0TIf/Vybk19oDd80Qkjthlop+YLf7I0OKBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760166910; c=relaxed/simple;
	bh=zYh5AZNh0giCYqW6m2MfvjvqFnisDhszlZCvD+OJOq8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CkHMvOTM+aJRbOpEETeyGxmlYTH9Ilac+Ld7T7l7sLD+ZE5Mch7JAeQ2ObTJAtI//WjbJonx67oY7lwGgrnck6C3RGReR/IOEmVcufNCTZj85XMEwJ3C8kn3Ql3A7i+23a9nzAHDLydMphLkoVIFVW5NrM5b01r+6+LQ3f89qmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5CLvZVj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5CLvZVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98313C4CEF4;
	Sat, 11 Oct 2025 07:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760166907;
	bh=zYh5AZNh0giCYqW6m2MfvjvqFnisDhszlZCvD+OJOq8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=p5CLvZVjaSlUBsfhUi8TMFqDbGpmdigWeU0f2DaNoL6NyNzns/vJ6gbl7mykI4gR0
	 Nk2GWw8ViL9VTkesLyX7eBYrQtiQ/ez9AwNTfb5QMgSis0KrjTWpsPOd1EzhTgrnQx
	 /JqbebVKvVpnf3tZoXlTIKRLo6h32AQyCpvWiSoOAwlMxHohzrTAbwr3q2Ww4z/hf4
	 MBWAPaxtr4LFn0IMqtroMFkU0xBIjDD5kZELzRA+e3fHIy8ntGQn7STj1kIW4yiV1c
	 cwleRn1DvpKRVRF4+JvXamk4WPDp/ZCn9jbmYBBSJMyqKfVpDUQk/Py3iLu4ZhJ3Fg
	 tRlD00i10f44g==
Message-ID: <b5222668-4982-439a-8ecf-7cc5ac12531d@kernel.org>
Date: Sat, 11 Oct 2025 15:15:02 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/009: Add delay after killing socket tool
To: Jan Prusakowski <jprusakowski@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20251006100713.3501501-1-jprusakowski@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251006100713.3501501-1-jprusakowski@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 18:07, Jan Prusakowski wrote:
> When running the test in a VM on a host with all CPUs busy, the kill command
> returns before socket tool shuts down. This prevents unmounting the
> scratch, causing the test to fail.
> 
> The added sleep ensures that the socket tool closes before the next test steps.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
