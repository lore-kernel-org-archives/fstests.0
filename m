Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8F41CB2D
	for <fstests@vger.kernel.org>; Wed, 12 Aug 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528701; cv=none; b=hwNwHEPlCQW8LqocBusQKdCUs68bQGhB+TB9890W7OcthuwWzw2kyFkENchDYHkmUbnFKhEHO3BzNgFl7UJy39bQDg879SerLWl6FAUVAW5jwiNg/ZAz9V1ruN8CN7ErVEg5Z2SKxTBA8KWkqKvkmYg2CajpX1O271j/JYiOpAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528701; c=relaxed/simple;
	bh=p4dlw/4ZqHpnpXrxukO340oJFU/sBOEESgjhRVhuNR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPdqc4rogVIiIyHbjnHGcTb049YEuMAcyiTXbasFuhwpKgkABKV4N6F5r6WiwYjaHnmkQkL/vux5JKcPx60BOnOTT9AFmubjIiCEeaYGNJqr22w9q4AZC7hRO5MaNtaMmJWQVLnv8sEdaKB2u3aGTBre765ejX4MQccSGckcJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZDdX7av; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZDdX7av"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AB51F000E9;
	Wed, 12 Aug 2026 09:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786528699;
	bh=juwc4TR4TJGZCuomB5VceZdR9BVexSnJUuq/3pObPtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aZDdX7avo0sMNmyRNofps8F2Jq9sjd3YlTilKShU+lflHcW9GXWRGWWhEwyCiC9zC
	 K7sOWUd4yQWf/n+luDuP6F+omF1kiLor7ePtW4du1V3RlgOhWiK4r4lDPqWSdz07qK
	 4mJJkgnsOQzcwMsBH+PJPZKrKfwm/0FUu6xIYyVXLy0XXUV0v3AGzpCGD+U4IrSvek
	 BRYMqVK7lKDaEAJ1CaAje/jC1zja8xLMQSJfgE7ziBerS2QEvvotTcmBBV2PVzaIWJ
	 zotKBqPYI05j6VENbr0e3VDA1fOP7HAMT6deGTEhbqo0AuI9OQ4TR3s1u/osPXYEEq
	 6zvJ+KxIi1tAw==
Date: Wed, 12 Aug 2026 11:58:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: Zizhi Wo <wozizhi@huaweicloud.com>, fstests@vger.kernel.org, 
	yangerkun@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH] idmapped-mounts: probe O_TMPFILE support with the
 caller's mapped id
Message-ID: <20260812-kurzarbeit-unabdingbar-mutter-e31cef822206@brauner>
References: <20260731090253.1665192-1-wozizhi@huaweicloud.com>
 <f705ea52-36da-4fdb-a41e-a67a10830919@huaweicloud.com>
 <anoyQqDV_ga7ttCg@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anoyQqDV_ga7ttCg@zlang-mailbox>

On Tue, Aug 11, 2026 at 04:40:18AM +0800, Zorro Lang wrote:
> On Thu, Aug 06, 2026 at 02:11:55PM +0800, Zizhi Wo wrote:
> > friendly ping...
> 
> Hi Zizhi, actually I'm waiting for the fix from vfs list.
> 
> Hi Christian,
> 
> Could you please take a look at this issue? Quite a few people have submitted
> patches trying to fix this test issue. Given that you are the authority on
> this topic and previously sent a patchset [1] to fix this kind of issue, I think
> accepting your patch would be the best approach to stay aligned with upstream
> VFS. Christoph also metioned that [2] last time. I don't want to make this issue
> fixing any more complicated. Could you please provide your review point or
> rebase your fix on the latest fstests for-next branch, we'll review it ASAP.

Just seeing this now.
Please accept my patch which is a lot simpler imho. Thanks!
