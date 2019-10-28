Return-Path: <SRS0=nTdV=YV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2688CA9EC0
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Oct 2019 14:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393F720659
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Oct 2019 14:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="H/BCnGNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfJ1OL3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:11:29 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25768 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728383AbfJ1OL2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Oct 2019 10:11:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572271867; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Yd74A+g/r+8muGl/2iBXio7LkdqyBuMqLauFgXRkkI1IhaWA4kqE/smyuPHhqAPD77AOWP8OjpgMHPB5P3djvpQRS9jadDlG2Hu960kIfKLW9IEBawRiWQVp8zuHB9/iVGSpDxxq4LitgrJ/mMORGWYML1k1K1a7zgZN6YCj1Ck=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572271867; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=+FGeF74G23qbBPk3DPNQVagsAG58vwejyDkkVF2v7+Q=; 
        b=kqP5asBdifJMdSoZBzmKzdfp/MSp24p8gSRImeHkWebVyrzcJrlaK6HSnwxjRnVy5lpseaqfSAHkZn0i2tn1IC+S6nVo1/QGxx9gKus5pWqzD8qvCkciPMN2tWe5r3y2ZSFpWOOpdi4jLRMEVGGNZFTa0OUFlGPLQgLBU4aJNmU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572271867;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=5601; bh=+FGeF74G23qbBPk3DPNQVagsAG58vwejyDkkVF2v7+Q=;
        b=H/BCnGNcEUHq2hO01W+yfK058KsCCbyJGzd2+6SlAh2QsYR32t7ktY7sDPqUccfr
        LJZwr4y80sDs7SNTJPkbD9uB7q/Fwzd5Uf0fHMzf/BHu5ewUslu8s5nluRKvchyHomW
        3smHaz5qD5adUap0DK1FHXfodRs+xbzL2PvqkBuQ=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1572271866583552.4492444651024; Mon, 28 Oct 2019 22:11:06 +0800 (CST)
Date:   Mon, 28 Oct 2019 22:11:06 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "fstests" <fstests@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "Eryu Guan" <guaneryu@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Message-ID: <16e12b4c2d4.107038d9f36138.3957762737837230842@mykernel.net>
In-Reply-To: <CAOQ4uxjFvTTbKRW1BChnzfNSqg1yeyM3gjwjZ77i161D_XLFRg@mail.gmail.com>
References: <20191024122923.24689-1-cgxu519@mykernel.net> <CAOQ4uxidZ=g29hGmKxinRA4Gp6CiWbOB9RqLWPPFXwtCB4DWog@mail.gmail.com>
 <16e007f78f9.12a9e815231850.7849365151361114799@mykernel.net>
 <CAOQ4uxgZDKnMGB3pbCJpyH_RxWzbEHLQMB2Mpc10PK=7=xYLOg@mail.gmail.com> <16e1244e1c9.ccaa038637864.8395134351025208019@mykernel.net> <CAOQ4uxjFvTTbKRW1BChnzfNSqg1yeyM3gjwjZ77i161D_XLFRg@mail.gmail.com>
Subject: Re: [PATCH v3] overlay/066: copy-up test for variant sparse files
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2019-10-28 20:29:03 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Mon, Oct 28, 2019 at 2:09 PM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E6=97=A5, 2019-10-27 21:59:36 Amir =
Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > >  > On Fri, Oct 25, 2019 at 4:19 AM Chengguang Xu <cgxu519@mykernel.net=
> wrote:
 > >  > >
 > >  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2019-10-25 05:02:07 =
Amir Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > >  > >  > On Thu, Oct 24, 2019 at 3:29 PM Chengguang Xu <cgxu519@mykerne=
l.net> wrote:
 > >  > >  > >
 > >  > >  > > This is intensive copy-up test for sparse files,
 > >  > >  > > these cases will be mainly used for regression test
 > >  > >  > > of copy-up improvement for sparse files.
 > >  > >  > >
 > >  > >  > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
 > >  > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > >  > >
 > >  > >  > > ---
 > >  > >  > > v1->v2:
 > >  > >  > > - Call _get_block_size to get fs block size.
 > >  > >  > > - Add comment for test space requirement.
 > >  > >  > > - Print meaningful error message when copy-up fail.
 > >  > >  > > - Adjust random hole range to 1M~5M.
 > >  > >  > > - Fix typo.
 > >  > >  > >
 > >  > >  > > v2->v3:
 > >  > >  > > - Fix space requiremnt for test.
 > >  > >  > > - Add more descriptions for test files and hole patterns.
 > >  > >  > > - Define well named variables to replace unexplained numbers=
.
 > >  > >  > > - Fix random hole algorithm to what Amir suggested.
 > >  > >  > > - Adjust iosize to start from 1K.
 > >  >
 > >  > Chengguang,
 > >  >
 > >  > Sorry, I did't notice that you did that. Why?
 > >  > As you can see below, this change has a very bad impact on test run=
 time.
 > >  > Any reason not to use _get_block_size?
 > >
 > > Use _get_block_size cannot mitigate the effect perfectly,
 > > in the worst case that we formatted fs with blocksize=3D1K,
 > > the test will  take long time and also test time is not fixed.
 > >
 > >  >
 > >  >
 > >  > >  > > - Remove from quick test group.
 > >  > >  >
 > >  > >  > Why? you said it takes 7s without the kernel patch.
 > >  > >  > The test overlay/001 is in quick group and it copies up 2*4GB
 > >  > >  > sparse files.
 > >  > >
 > >  > > I noticed that after changed to start from 1K iosize the test too=
k about 23s.
 > >  > > I'm afraid maybe it will take more time on low performance VM env=
.
 > >  > >
 > >  > > The test overlay/001 took 8s/1s with/without kernel patch, so mai=
nly test time
 > >  > > wasted on creating test files on test overlay/066.
 > >  >
 > >  > You are correct about the time spent on creating the files, but...
 > >  >
 > >  > On my low perf VM, the test runs 95s with overlay over xfs+reflink
 > >  >
 > >  > But if I set start iosize=3D4 (which what my fs block size is) the =
test
 > >  > runs only 30s.
 > >  >
 > >  > IOW, most of the test time is spent on creating the files with smal=
l iosize
 > >  > below fs block size, which doesn't test copy up of holes at all.
 > >  >
 > >  > If I further change file size to be a multiply of iosize (x10),
 > >  > test run time drops to 6s!
 > >  > I don't think we loose too much test coverage if we do that?
 > >  > If anything we gain testing different file sizes.
 > >
 > > hmm, for small iosize the file size is even smaller than
 > > copy-up CHUNK SIZE(1M),  so that all contents(data+hole)
 > > will be passed at once, I'm not very sure is it helpful for
 > > hole copy-up logic in kernel patch. What do you think?
 > >
 >=20
 > Not sure. I don't think we should target the test by what we know your
 > patch does, but by maximizing test coverage in a cost effective way.
 >=20
 > Creating a 10M file with so many small holes doesn't add much to test
 > coverage IMO. If you feel those are needed, you should use a C helper
 > to create those files more efficiently.
 >=20
 > BTW I think what is missing from test coverage is small holes
 > that are not aligned to 1M boundary.
 >=20

Agreed.

So how about change test pattern to below, it will cover  most of the
cases that we want. I haven't done test for the performance(test time)
but I think it will be fast enough.


One 4K empty file.
One 4M empty file.
One 10M file with random small holes (4K~512K)
One 100M file with random big holes (1M~5M)


 >=20
 > >
 > >  >
 > >  > The disk space requirement formula for ${iosize}K_holefiles becomes=
:
 > >  > 10*(2^0 + 2^11)K*12/2 =3D~ 10 * 1024 * 12
 > >
 > > That's the mean of 12/2 ?
 >=20
 > it's the formula to the sum of the series:
 > 2^0+2^2+...2^11 =3D (2^0 + 2^11)*12/2

oh, sorry, I misread the formula.=20

 >=20
 > >
 > >  > same as before, just needs explaining.
 > >  > (the formula assumes the worst case of min_iosize=3D1)
 > >  >
 > >  > -------------
 > >  >  #
 > >  >  # |-- hole --|-- data --| ... |-- data --|-- hole --|
 > >  >
 > >  > -iosize=3D1
 > >  > +min_iosize=3D$(($(_get_block_size "${lowerdir}") / 1024 ))
 > >  > +iosize=3D$min_iosize
 > >  >  max_iosize=3D2048
 > >  > -file_size=3D10240
 > >  > -max_pos=3D`expr $file_size - $max_iosize`
 > >  >
 > >  >  while [ $iosize -le $max_iosize ]; do
 > >  > +       file_size=3D$((10*$iosize))
 > >  > +       max_pos=3D`expr $file_size - $iosize`
 > >  > +       date >>$seqres.full
 > >
 > > That's the purpose for putting data info here?
 >=20
 > leftover from my debugging patch to figure out what takes so much time
 > You don't need it
 >=20
 > Thanks,
 > Amir.
 >

