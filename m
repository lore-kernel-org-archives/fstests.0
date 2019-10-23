Return-Path: <SRS0=nbej=YQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A315BCA9EB6
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Oct 2019 13:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F8E21872
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Oct 2019 13:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDlmxLxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405592AbfJWNJn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:09:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56088 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405577AbfJWNJm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Oct 2019 09:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571836181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QXnG/sW0BFEoqSeQ2PwL8/nR23nCaAvkqp4zs0EhNRU=;
        b=VDlmxLxYf+BAA9B2UE9MZLNAIE6cgcPy4F2KP/dm2I/RTwaPgItzIqg8Tgfyyd9BhhPD3I
        T96vlf11wRr/NEwCuZuqG7JjbGvAWiHVh4XZsYseDHX4URFMeVNh6U4Y03OUpDM9l+XhtK
        W0VeT2V6cXQbWi8BI1Jc95lleVTjI9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-OSIlmbqvOPuL32dmub8Etg-1; Wed, 23 Oct 2019 09:09:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C21B280183E;
        Wed, 23 Oct 2019 13:09:36 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E4960BE1;
        Wed, 23 Oct 2019 13:09:36 +0000 (UTC)
Date:   Wed, 23 Oct 2019 09:09:34 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     fstests@vger.kernel.org,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [PATCH] ltp/fsx: hornor keep_size_calls when replaying operations
Message-ID: <20191023130934.GD59518@bfoster>
References: <20191022123115.12250-1-eguan@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20191022123115.12250-1-eguan@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: OSIlmbqvOPuL32dmub8Etg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 22, 2019 at 08:31:15PM +0800, Eryu Guan wrote:
> When replaying fsx operations with "--replay-ops opsfile" option, the
> ops described by opsfile may contain 'keep_size' directive for fallocate
> and/or zero_range operations, but it's possible that the underlying
> filesystem doesn't support KEEP_SIZE flag and causes fsx reports false
> failure, despite the 'keep_size_calls' switch is set to false.
>=20
> For example, running generic/469 on NFSv4, which supports fallocate(2)
> but not the KEEP_SIZE flag, we see:
>=20
> main: filesystem does not support fallocate mode FALLOC_FL_KEEP_SIZE, dis=
abling!
> main: filesystem does not support fallocate mode FALLOC_FL_PUNCH_HOLE | F=
ALLOC_FL_KEEP_SIZE, disabling!
> main: filesystem does not support fallocate mode FALLOC_FL_ZERO_RANGE, di=
sabling!
> main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE=
, disabling!
> main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, =
disabling!
> main: filesystem does not support clone range, disabling!
> main: filesystem does not support dedupe range, disabling!
> fallocate: 0x0 to 0x1000
> do_preallocate: fallocate: Operation not supported
> LOG DUMP (1 total operations):
> 1(  1 mod 256): FALLOC   0x0 thru 0x1000        (0x1000 bytes) PAST_EOF
> Log of operations saved to "/test1/469.fsx.fsxops"; replay with --replay-=
ops
> Correct content saved for comparison
> (maybe hexdump "/test1/469.fsx" vs "/test1/469.fsx.fsxgood")
>=20
> Fix it by making sure 'keep_size_calls' is true when 'keep_size' is
> set, otherwise just skip the operation.
>=20

Wouldn't you want fsx to fail if you fed it an ops file to replay that
the current system/fs cannot accommodate? I suppose that's not a big
deal if it requires an explicit parameter (-K) to change behavior, but
it doesn't look like generic/469 uses that anyways.. hm?

Brian

> Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
> ---
>  ltp/fsx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 06d08e4e93f3..ae89bf665db4 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2044,6 +2044,9 @@ have_op:
>  =09=09if (!fallocate_calls) {
>  =09=09=09log4(OP_FALLOCATE, offset, size, FL_SKIPPED);
>  =09=09=09goto out;
> +=09=09} else if (keep_size && !keep_size_calls) {
> +=09=09=09log4(OP_FALLOCATE, offset, size, FL_SKIPPED | FL_KEEP_SIZE);
> +=09=09=09goto out;
>  =09=09}
>  =09=09break;
>  =09case OP_PUNCH_HOLE:
> @@ -2056,6 +2059,9 @@ have_op:
>  =09=09if (!zero_range_calls) {
>  =09=09=09log4(OP_ZERO_RANGE, offset, size, FL_SKIPPED);
>  =09=09=09goto out;
> +=09=09} else if (keep_size && !keep_size_calls) {
> +=09=09=09log4(OP_ZERO_RANGE, offset, size, FL_SKIPPED | FL_KEEP_SIZE);
> +=09=09=09goto out;
>  =09=09}
>  =09=09break;
>  =09case OP_COLLAPSE_RANGE:
> --=20
> 2.14.4.44.g2045bb6
>=20

