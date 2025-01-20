Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181E1E32DB
	for <fstests@vger.kernel.org>; Mon, 20 Jan 2025 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387834; cv=none; b=c+oScPid4xqWwO68nfG3L7XGwuKDVOVc0Rmiy5uKcIVaMzHc79RM7my7QpqkSrTHr2pnBzn8hnkBbmV3ZOvmMdNqIscYQUj9pb9RoJwxl7H8dYRCB+RDba+l/G70X76+m7YDMLNJwhoMprApBi29RoQsnsCDGeynf9woJUMZh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387834; c=relaxed/simple;
	bh=7GSgh24e7Lrx6jF7Y+WvZ/VFxDmY/RDDmKTerlQyylE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=O8FZSsVQmd9hwCuZQPam5jSZc7/84HJVzInfTQeNVMadR7NPRw94DbJyz9/On1iXlldA6iZSh06czfmR/s45jhtvPdbtOr018gr8KY/FEuREYk53drbdSluNf86V02AWlJi9D+IxBRytflAC19VHGf3k6INkfNGLkQDImKWVMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIn/r90D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIn/r90D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737387831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7GSgh24e7Lrx6jF7Y+WvZ/VFxDmY/RDDmKTerlQyylE=;
	b=HIn/r90D1wCo8UPH/9GfgWxUk9ayLKbniRlCdxVc5+s1u0PZfvlQkfAyEUAdsLjBUN0ysW
	NAqE5sj85zNAgVV/atDc58XMxOU31PgLrsaHcAh3o6S5cHyA7JFRlq3SEx7UPU6Fwx8kgV
	RICD5kMTeoK6MAww+kyZUoRnaPvPyRs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-vONu1RTdPVW21o9O61ZlCg-1; Mon,
 20 Jan 2025 10:43:50 -0500
X-MC-Unique: vONu1RTdPVW21o9O61ZlCg-1
X-Mimecast-MFC-AGG-ID: vONu1RTdPVW21o9O61ZlCg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DE5C1955BD9;
	Mon, 20 Jan 2025 15:43:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C30AC3003FD2;
	Mon, 20 Jan 2025 15:43:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1201003.1737382806@warthog.procyon.org.uk>
References: <1201003.1737382806@warthog.procyon.org.uk> <1113699.1737376348@warthog.procyon.org.uk>
To: Eric Biggers <ebiggers@google.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    fstests@vger.kernel.org, ceph-devel@vger.kernel.org,
    linux-fsdevel@vger.kernel.org
Subject: Re: Error in generic/397 test script?
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1207324.1737387826.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jan 2025 15:43:46 +0000
Message-ID: <1207325.1737387826@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

David Howells <dhowells@redhat.com> wrote:

> However, in this case (in which I'm running these against ceph), I don't=
 think
> that the find should return nothing, so it's not a bug in the test scrip=
t per
> se.

Turned out that I hadn't enabled XTS and so the tests for xts(aes) failed =
and
produced no files.

David

