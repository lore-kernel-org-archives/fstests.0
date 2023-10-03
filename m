Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BBAE7545C
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Oct 2023 18:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjJCSaS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjJCSaS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Oct 2023 14:30:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5908B8
        for <fstests@vger.kernel.org>; Tue,  3 Oct 2023 11:30:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC59C433C8;
        Tue,  3 Oct 2023 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696357814;
        bh=KZYIYKVHDq8ubk0Yar1HmE5SZAtgwB+RDnXH/YZnsrk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VkRgwiW2fw2RObcJtVjN8tSpa1U05Zo55RQrl2Zci/h+LZe2g0CkmX111ssGeqXbD
         fhHDfVfyPQHNw/ojsZkGAxMpI4urPQmfA78qgvGVhaQy0GYYr0HGHyIfqeL5HuHf+H
         +ASYlS+uGzX2Q5v7tWEJkZlQkben5NlHhM60J6y8apImOn6XCQvjoyOQ0hopmVvt5j
         UoJZx6zPipSR5wz/ltT+zppMAuEKl3xHOlSd4Ew+I8gPziAe5GmIFGHp83p9eDd8Fk
         vIAWfO1Nsm0yyrPY+eBlWzmgKNxFmhp02x1ZBDbV2O4BSdrIKlsFnZysvAhHCRmQMa
         3d0SuVpSgNRNA==
Message-ID: <82cc1f923b76f076be0808de50aff79becf673f0.camel@kernel.org>
Subject: Re: [PATCH][RESEND] generic/478: add F_UNLCK testing
From:   Jeff Layton <jlayton@kernel.org>
To:     stsp <stsp2@yandex.ru>, fstests@vger.kernel.org
Cc:     Murphy Zhou <xzhou@redhat.com>, Zorro Lang <zlang@redhat.com>
Date:   Tue, 03 Oct 2023 14:30:12 -0400
In-Reply-To: <163917ba-5597-493a-9856-560ed49df889@yandex.ru>
References: <20230925110027.2141499-1-stsp2@yandex.ru>
         <3645c31d33685a444265ab65fddad3ba596224cb.camel@kernel.org>
         <163917ba-5597-493a-9856-560ed49df889@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 2023-10-03 at 22:43 +0500, stsp wrote:
> =C2=A0
>=20
>=20
> =C2=A0
>=20
> =C2=A0
>=20
> 03.10.2023 22:39, Jeff Layton =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> =C2=A0
>=20
> > =C2=A0
> >=20
> > The problem here is that old kernels are going to fail the new tests,
> > and it's going to be hard to engineer the output of 478 to account for
> > that.
> > =C2=A0
> >=20
> =C2=A0
>=20
> What do you mean?
> =C2=A0My patch does exactly that, and for
> =C2=A0that I added the -U option.
> =C2=A0
>=20

I mean that that functionality would be better implemented as a
_require_* test rather than hidden plumbing inside t_ofd_locks.c like
that.

--=20
Jeff Layton <jlayton@kernel.org>
