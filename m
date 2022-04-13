Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2301AC433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 02:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiDMCMH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Apr 2022 22:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiDMCMG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Apr 2022 22:12:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783132126A
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 19:09:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q14so480167ljc.12
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 19:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rg4K1nT/MGulzVvSD7ypqho9v3owfn33EzDBAFyJr9s=;
        b=Y6sjfGjtzEVi78J1c/JXGZaqCMQsYCm5sGs1qxRleptVg2fpt19KRJUcv2HresPQNK
         KGUWVzboJIRa+V6M3AuVh0g/7W8SQlOGlHvsqjei2LoU9/rlYE5BAj1lYNew2wK3eHV4
         P5buUlD5jBeMX6nfP1Cncfl4gZV8IwNlg3KDVdWpT2kHQHRA+bZsfbU4zsiIVUGVIHFH
         dye8WK1GwKh1iUB5vyn8zT5ZA6NxO3Etg72baaW8szgw5XOWHZEkEP1jqWHg5zYJHVqi
         hvD/AXolzmcwsB1e3icrGKlYPX0DKdsnnRgKoVPlpSbw1C1j2WDmLux6ovvg3G57PwaH
         QMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rg4K1nT/MGulzVvSD7ypqho9v3owfn33EzDBAFyJr9s=;
        b=LsJkLNjST4CuT0hGevVYBMGDDL7eiSlViDawwwAhK9Fwlc0bHdS09Nk8sYwVAer7Ag
         SU2CvB7DqdhpAIY4DKIi6WtvAUqvkB9QHtxa2ZBABCAvwoVEgfU6qt5fNhamGygH7sO9
         buAEHdiOqxm+ZxtsO/96txTRIDAPb4dddXJREzbmGOB4KEyIqXcwcy0Qx+Sz7pZgSTOP
         oRpTKl/Ei0dEKMwB+17lkaD/EAc5tSjLU3vCht70BpAHWsXlYH/2TYfBtcQiB2zHWaz1
         tSJhgwzOhEPADumrcPyTH9Z3DdCjeKz7aw86JX1XRmkMs/aY/eON0fZjZw49LClW0k8C
         ShNQ==
X-Gm-Message-State: AOAM531nS7kaMpoKi3X3cu7K81T8pzs7JORw2nc47R1e8jj+fOEdQ90W
        joZ7tnUcE9XyWx3lQyCrEcm0u8Re+MnnOp6f/EgqTg==
X-Google-Smtp-Source: ABdhPJwe4XQUMx3lP+IHCUZXMycOmxgDO23fChF/WgLAXZQairb2af2v+dn+pIoZn1PZSIsGQgXaJ7Jb2nx1uuA/zH0=
X-Received: by 2002:a05:651c:1a0e:b0:24c:83e3:14f3 with SMTP id
 by14-20020a05651c1a0e00b0024c83e314f3mr547313ljb.376.1649815783323; Tue, 12
 Apr 2022 19:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220412194807.617356-1-nhuck@google.com> <YlX9VD0Ixj/H4YBF@sol.localdomain>
In-Reply-To: <YlX9VD0Ixj/H4YBF@sol.localdomain>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Tue, 12 Apr 2022 21:09:31 -0500
Message-ID: <CAJkfWY6YJSKc1-43J-nBhiD8-e+w_s0qE=wjnAg=FfXLN+6qYw@mail.gmail.com>
Subject: Re: [RFC PATCH] fscrypt-crypt-util: add HCTR2 tests
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 12, 2022 at 5:29 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Apr 12, 2022 at 02:48:07PM -0500, Nathan Huckleberry wrote:
> > This patch is not intended to be accepted yet.  It is reliant on HCTR2
> > support in the kernel which has not yet been accepted.  See the HCTR2
> > patch here:
> > https://lore.kernel.org/all/20220412172816.917723-1-nhuck@google.com/
> >
> > HCTR2 is a new wide-block encryption mode that can used for filename
> > encryption in fscrypt.  This patch adds tests for fscrypt policies using
> > HCTR2 for filename encryption.
> >
> > More information on HCTR2 can be found here:
> > Length-preserving encryption with HCTR2
> > https://ia.cr/2021/1441
> >
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> >  common/encrypt           |   2 +
> >  src/fscrypt-crypt-util.c | 452 ++++++++++++++++++++++++++++++++++-----
> >  tests/generic/678        |  24 +++
> >  tests/generic/678.out    |   5 +
> >  tests/generic/679        |  26 +++
> >  tests/generic/679.out    |   6 +
> >  tests/generic/680        |  26 +++
> >  tests/generic/680.out    |   6 +
> >  tests/generic/681        |  26 +++
> >  tests/generic/681.out    |   6 +
> >  10 files changed, 523 insertions(+), 56 deletions(-)
> >  create mode 100755 tests/generic/678
> >  create mode 100644 tests/generic/678.out
> >  create mode 100755 tests/generic/679
> >  create mode 100644 tests/generic/679.out
> >  create mode 100755 tests/generic/680
> >  create mode 100644 tests/generic/680.out
> >  create mode 100755 tests/generic/681
> >  create mode 100644 tests/generic/681.out
>
> Please Cc linux-fscrypt@vger.kernel.org for all encryption xfstests updates.
>
> The subject line "fscrypt-crypt-util:" is a bit misleading, as it makes it sound
> like this patch just updates the fscrypt-crypt-util helper program.  Actually it
> adds new test scripts too.  I recommend splitting the test scripts into a
> separate patch.
>
> This patch doesn't apply to the master branch of xfstests anymore, since someone
> already created tests with numbers 678-679.  To avoid these types of conflicts,
> usually people use other unused test numbers in xfstests patches, like 900-910,
> and the xfstests maintainer renumbers the tests when applying the patch.
>
> > @@ -54,7 +55,8 @@ static void usage(FILE *fp)
> >  "resulting ciphertext (or plaintext) to stdout.\n"
> >  "\n"
> >  "CIPHER can be AES-256-XTS, AES-256-CTS-CBC, AES-128-CBC-ESSIV, AES-128-CTS-CBC,\n"
> > -"or Adiantum.  MASTER_KEY must be a hex string long enough for the cipher.\n"
> > +"Adiantum, or AES-256-HCTR2.  MASTER_KEY must be a hex string long enough for\n"
> > +"the cipher."
>
> There should be a newline at the end of the above line.
>
> > +#include <linux/if_alg.h>
> > +#include <sys/socket.h>
> > +#define SOL_ALG 279
> > +static void af_alg_crypt(int algfd, int op, const u8 *key, size_t keylen,
> > +                      const u8 *iv, size_t ivlen,
> > +                      const u8 *src, u8 *dst, size_t datalen)
> > +{
> > +     size_t controllen = CMSG_SPACE(sizeof(int)) +
> > +                         CMSG_SPACE(sizeof(struct af_alg_iv) + ivlen);
> > +     u8 *control = xmalloc(controllen);
> > +     struct iovec iov = { .iov_base = (u8 *)src, .iov_len = datalen };
> > +     struct msghdr msg = {
> > +             .msg_iov = &iov,
> > +             .msg_iovlen = 1,
> > +             .msg_control = control,
> > +             .msg_controllen = controllen,
> > +     };
> > +     struct cmsghdr *cmsg;
> > +     struct af_alg_iv *algiv;
> > +     int reqfd;
> > +
> > +     memset(control, 0, controllen);
> > +
> > +     cmsg = CMSG_FIRSTHDR(&msg);
> > +     cmsg->cmsg_len = CMSG_LEN(sizeof(int));
> > +     cmsg->cmsg_level = SOL_ALG;
> > +     cmsg->cmsg_type = ALG_SET_OP;
> > +     *(int *)CMSG_DATA(cmsg) = op;
> > +
> > +     cmsg = CMSG_NXTHDR(&msg, cmsg);
> > +     cmsg->cmsg_len = CMSG_LEN(sizeof(struct af_alg_iv) + ivlen);
> > +     cmsg->cmsg_level = SOL_ALG;
> > +     cmsg->cmsg_type = ALG_SET_IV;
> > +     algiv = (struct af_alg_iv *)CMSG_DATA(cmsg);
> > +     algiv->ivlen = ivlen;
> > +     memcpy(algiv->iv, iv, ivlen);
> > +
> > +     if (setsockopt(algfd, SOL_ALG, ALG_SET_KEY, key, keylen) != 0)
> > +             die_errno("can't set key on AF_ALG socket");
> > +
> > +     reqfd = accept(algfd, NULL, NULL);
> > +     if (reqfd < 0)
> > +             die_errno("can't accept() AF_ALG socket");
> > +     if (sendmsg(reqfd, &msg, 0) != datalen)
> > +             die_errno("can'datalen, t sendmsg() AF_ALG request socket");
>
> Something went wrong when copying the above error message.
>
> > +     if (xread(reqfd, dst, datalen) != datalen)
> > +             die("short read from AF_ALG request socket");
> > +     close(reqfd);
> > +
> > +     free(control);
> > +}
> >  #endif
>
> Please add a comment by the #endif, like "#endif /* ENABLE_ALG_TESTS */", since
> this #if-#endif block encloses a lot of code now.
>
> >  /*----------------------------------------------------------------------------*
> >   *                          Finite field arithmetic                           *
> >   *----------------------------------------------------------------------------*/
> >
> > +#define gf128mul_dat(q) { \
> > +     q(0x00), q(0x01), q(0x02), q(0x03), q(0x04), q(0x05), q(0x06), q(0x07),\
> > +     q(0x08), q(0x09), q(0x0a), q(0x0b), q(0x0c), q(0x0d), q(0x0e), q(0x0f),\
> > +     q(0x10), q(0x11), q(0x12), q(0x13), q(0x14), q(0x15), q(0x16), q(0x17),\
> > +     q(0x18), q(0x19), q(0x1a), q(0x1b), q(0x1c), q(0x1d), q(0x1e), q(0x1f),\
> > +     q(0x20), q(0x21), q(0x22), q(0x23), q(0x24), q(0x25), q(0x26), q(0x27),\
> > +     q(0x28), q(0x29), q(0x2a), q(0x2b), q(0x2c), q(0x2d), q(0x2e), q(0x2f),\
> > +     q(0x30), q(0x31), q(0x32), q(0x33), q(0x34), q(0x35), q(0x36), q(0x37),\
> > +     q(0x38), q(0x39), q(0x3a), q(0x3b), q(0x3c), q(0x3d), q(0x3e), q(0x3f),\
> > +     q(0x40), q(0x41), q(0x42), q(0x43), q(0x44), q(0x45), q(0x46), q(0x47),\
> > +     q(0x48), q(0x49), q(0x4a), q(0x4b), q(0x4c), q(0x4d), q(0x4e), q(0x4f),\
> > +     q(0x50), q(0x51), q(0x52), q(0x53), q(0x54), q(0x55), q(0x56), q(0x57),\
> > +     q(0x58), q(0x59), q(0x5a), q(0x5b), q(0x5c), q(0x5d), q(0x5e), q(0x5f),\
> > +     q(0x60), q(0x61), q(0x62), q(0x63), q(0x64), q(0x65), q(0x66), q(0x67),\
> > +     q(0x68), q(0x69), q(0x6a), q(0x6b), q(0x6c), q(0x6d), q(0x6e), q(0x6f),\
> > +     q(0x70), q(0x71), q(0x72), q(0x73), q(0x74), q(0x75), q(0x76), q(0x77),\
> > +     q(0x78), q(0x79), q(0x7a), q(0x7b), q(0x7c), q(0x7d), q(0x7e), q(0x7f),\
> > +     q(0x80), q(0x81), q(0x82), q(0x83), q(0x84), q(0x85), q(0x86), q(0x87),\
> > +     q(0x88), q(0x89), q(0x8a), q(0x8b), q(0x8c), q(0x8d), q(0x8e), q(0x8f),\
> > +     q(0x90), q(0x91), q(0x92), q(0x93), q(0x94), q(0x95), q(0x96), q(0x97),\
> > +     q(0x98), q(0x99), q(0x9a), q(0x9b), q(0x9c), q(0x9d), q(0x9e), q(0x9f),\
> > +     q(0xa0), q(0xa1), q(0xa2), q(0xa3), q(0xa4), q(0xa5), q(0xa6), q(0xa7),\
> > +     q(0xa8), q(0xa9), q(0xaa), q(0xab), q(0xac), q(0xad), q(0xae), q(0xaf),\
> > +     q(0xb0), q(0xb1), q(0xb2), q(0xb3), q(0xb4), q(0xb5), q(0xb6), q(0xb7),\
> > +     q(0xb8), q(0xb9), q(0xba), q(0xbb), q(0xbc), q(0xbd), q(0xbe), q(0xbf),\
> > +     q(0xc0), q(0xc1), q(0xc2), q(0xc3), q(0xc4), q(0xc5), q(0xc6), q(0xc7),\
> > +     q(0xc8), q(0xc9), q(0xca), q(0xcb), q(0xcc), q(0xcd), q(0xce), q(0xcf),\
> > +     q(0xd0), q(0xd1), q(0xd2), q(0xd3), q(0xd4), q(0xd5), q(0xd6), q(0xd7),\
> > +     q(0xd8), q(0xd9), q(0xda), q(0xdb), q(0xdc), q(0xdd), q(0xde), q(0xdf),\
> > +     q(0xe0), q(0xe1), q(0xe2), q(0xe3), q(0xe4), q(0xe5), q(0xe6), q(0xe7),\
> > +     q(0xe8), q(0xe9), q(0xea), q(0xeb), q(0xec), q(0xed), q(0xee), q(0xef),\
> > +     q(0xf0), q(0xf1), q(0xf2), q(0xf3), q(0xf4), q(0xf5), q(0xf6), q(0xf7),\
> > +     q(0xf8), q(0xf9), q(0xfa), q(0xfb), q(0xfc), q(0xfd), q(0xfe), q(0xff) \
> > +}
> > +
> > +#define xda_be(i) ( \
> > +     (i & 0x80 ? 0x4380 : 0) ^ (i & 0x40 ? 0x21c0 : 0) ^ \
> > +     (i & 0x20 ? 0x10e0 : 0) ^ (i & 0x10 ? 0x0870 : 0) ^ \
> > +     (i & 0x08 ? 0x0438 : 0) ^ (i & 0x04 ? 0x021c : 0) ^ \
> > +     (i & 0x02 ? 0x010e : 0) ^ (i & 0x01 ? 0x0087 : 0) \
> > +)
> > +
> > +#define xda_le(i) ( \
> > +     (i & 0x80 ? 0xe100 : 0) ^ (i & 0x40 ? 0x7080 : 0) ^ \
> > +     (i & 0x20 ? 0x3840 : 0) ^ (i & 0x10 ? 0x1c20 : 0) ^ \
> > +     (i & 0x08 ? 0x0e10 : 0) ^ (i & 0x04 ? 0x0708 : 0) ^ \
> > +     (i & 0x02 ? 0x0384 : 0) ^ (i & 0x01 ? 0x01c2 : 0) \
> > +)
> > +
> > +static const u16 gf2_128_mul_table_le[256] = gf128mul_dat(xda_le);
> > +
> >  /* Multiply a GF(2^8) element by the polynomial 'x' */
> >  static inline u8 gf2_8_mul_x(u8 b)
> >  {
> > @@ -292,8 +397,13 @@ typedef struct {
> >       __le64 hi;
> >  } ble128;
> >
> > +typedef struct {
> > +     __le64 hi;
> > +     __le64 lo;
> > +} be128;
> > +
> >  /* Multiply a GF(2^128) element by the polynomial 'x' */
> > -static inline void gf2_128_mul_x(ble128 *t)
> > +static inline void gf2_128_mul_x_ble(ble128 *t)
> >  {
> >       u64 lo = le64_to_cpu(t->lo);
> >       u64 hi = le64_to_cpu(t->hi);
> > @@ -302,6 +412,66 @@ static inline void gf2_128_mul_x(ble128 *t)
> >       t->lo = cpu_to_le64((lo << 1) ^ ((hi & (1ULL << 63)) ? 0x87 : 0));
> >  }
> >
> > +static inline void gf2_128_mul_x_lle(be128 *t)
> > +{
> > +     u64 hi = be64_to_cpu(t->hi);
> > +     u64 lo = be64_to_cpu(t->lo);
> > +
> > +     u64 _tt = (lo & (1ULL)) ? ((u64)0xe1 << 56) : 0;
> > +
> > +     t->lo = cpu_to_be64((lo >> 1) | (hi << 63));
> > +     t->hi = cpu_to_be64((hi >> 1) ^ _tt);
> > +}
> > +
> > +static inline void gf2_128_mul_x8_lle(be128 *t)
> > +{
> > +     u64 hi = be64_to_cpu(t->hi);
> > +     u64 lo = be64_to_cpu(t->lo);
> > +     u64 _tt = gf2_128_mul_table_le[lo & 0xff];
> > +
> > +     t->lo = cpu_to_be64((lo >> 8) | (hi << 56));
> > +     t->hi = cpu_to_be64((hi >> 8) ^ (_tt << 48));
> > +}
> > +
> > +void gf2_128_mul_lle(be128 *r, const be128 *b)
> > +{
> > +     be128 p[8];
> > +     int i;
> > +
> > +     p[0] = *r;
> > +     for (i = 0; i < 7; ++i) {
> > +             memcpy(&p[i + 1], &p[i], sizeof(be128));
> > +             gf2_128_mul_x_lle(&p[i + 1]);
> > +     }
> > +
> > +     memset(r, 0, sizeof(*r));
> > +     for (i = 0;;) {
> > +             u8 ch = ((u8 *)b)[15-i];
> > +
> > +             if (ch & 0x80)
> > +                     xor((u8 *)r, (u8 *)r, (u8 *)&p[0], sizeof(*r));
> > +             if (ch & 0x40)
> > +                     xor((u8 *)r, (u8 *)r, (u8 *)&p[1], sizeof(*r));
> > +             if (ch & 0x20)
> > +                     xor((u8 *)r, (u8 *)r, (u8 *)&p[2], sizeof(*r));
> > +             if (ch & 0x10)
> > +                     xor((u8 *)r, (u8 *)r, (u8 *)&p[3], sizeof(*r));
> > +             if (ch & 0x08)
> > +                     xor((u8 *)r, (u8 *)r, (u8 *)&p[4], sizeof(*r));
> > +             if (ch & 0x04)
> > +                     xor((u8 *)r, (u8 *)r, (u8 *)&p[5], sizeof(*r));
> > +             if (ch & 0x02)
> > +                     xor((u8 *)r, (u8 *)r, (u8 *)&p[6], sizeof(*r));
> > +             if (ch & 0x01)
> > +                     xor((u8 *)r, (u8 *)r, (u8 *)&p[7], sizeof(*r));
> > +
> > +             if (++i >= 16)
> > +                     break;
> > +
> > +             gf2_128_mul_x8_lle(r);
> > +     }
> > +}
> > +
>
> A few comments here.  This program is meant to implement all the algorithms in
> as simple a way as possible.  It doesn't have constraints like performance,
> trying to be constant-time, integration with an existing code-base, etc.
>
> With that being the case, can you try to simplify this as much as possible?  Is
> the multiplication table needed, or is that just an optimization?  You've also
> added some unused code, such as xda_be(); that's definitely not needed.

I can swap the table for an implementation of "peasant multiplication".

I will send a v2 with that and the other comments addressed.

>
> The following is definitely wrong, or at least named wrong:
>
>         typedef struct {
>                 __le64 hi;
>                 __le64 lo;
>         } be128;
>
> If it's a big endian integer, it shouldn't have little endian fields.
>
> POLYVAL also doesn't natively use lle-style field multiplication, but rather
> ble.  Wouldn't it be simpler to just implement the ble multiplication directly?
>
> > +/*----------------------------------------------------------------------------*
> > + *                                 POLVAL                                     *
> > + *----------------------------------------------------------------------------*/
>
> POLVAL => POLYVAL.
>
> For all new algorithms, please also include a link to their specification.
>
> > +static void polyval(const u8 key[POLYVAL_KEY_SIZE],
> > +                 const u8 *msg, size_t msglen, be128 *out)
>
> This isn't actually the whole POLYVAL, but rather just the "update" step.  So it
> should be called "polyval_update", and 'out' should be called something else
> since it is the accumulator (input/output).
>
> Also why does the accumulator have the type be128?  It's not big endian.  Can it
> just be a byte array here?
>
> > +     be128 h;
> > +     be128 tmp;
> > +     int nblocks = msglen / POLYVAL_BLOCK_SIZE;
> > +     int tail = msglen % POLYVAL_BLOCK_SIZE;
> > +
> > +     reverse_bytes(out);
> > +     memcpy(&h, key, sizeof(h));
> > +     reverse_bytes(&h);
> > +     gf2_128_mul_x_lle(&h);
> > +
> > +     while (nblocks > 0) {
> > +             memcpy(&tmp, msg, sizeof(tmp));
> > +             reverse_bytes(&tmp);
> > +             xor((u8 *)out, (u8 *)out, (u8 *)&tmp, sizeof(tmp));
> > +             gf2_128_mul_lle(out, &h);
> > +             msg += POLYVAL_BLOCK_SIZE;
> > +             nblocks--;
> > +     }
> > +     if (tail) {
> > +             memset(&tmp, 0, POLYVAL_BLOCK_SIZE);
> > +             memcpy(&tmp, msg, tail);
> > +             reverse_bytes(&tmp);
> > +             xor((u8 *)out, (u8 *)out, (u8 *)&tmp, sizeof(tmp));
> > +             gf2_128_mul_lle(out, &h);
> > +     }
> > +     reverse_bytes(out);
> > +}
>
> With a from-scratch implementation is it really easiest to use the reverse_bytes
> method?  I thought that this type of implementation is only recommended if there
> is an existing GHASH implementation.  Here there isn't.
>
> > +static void aes_256_xctr_crypt(const u8 key[AES_256_KEY_SIZE],
> > +                           const u8 iv[AES_BLOCK_SIZE], const u8 *src,
> > +                           u8 *dst, size_t nbytes)
> > +{
> > +     struct aes_key k;
> > +     int i;
> > +     int nblocks;
> > +     le128 ctr;
> > +     u8 keystream[AES_BLOCK_SIZE];
> > +
> > +     aes_setkey(&k, key, AES_256_KEY_SIZE);
> > +
> > +     nblocks = nbytes / AES_BLOCK_SIZE;
> > +     for (i = 0; i < nblocks; i++) {
> > +             ctr.hi = 0;
> > +             ctr.lo = cpu_to_le64(i + 1);
> > +             xor((u8 *)&ctr, (u8 *)&ctr, iv, AES_BLOCK_SIZE);
> > +             aes_encrypt(&k, (u8 *)&ctr, keystream);
> > +             xor(dst, keystream, src, AES_BLOCK_SIZE);
> > +             src += AES_BLOCK_SIZE;
> > +             dst += AES_BLOCK_SIZE;
> > +     }
> > +
> > +     if (nbytes % AES_BLOCK_SIZE != 0) {
> > +             ctr.hi = 0;
> > +             ctr.lo = cpu_to_le64(nbytes / AES_BLOCK_SIZE + 1);
> > +             xor((u8 *)&ctr, (u8 *)&ctr, iv, AES_BLOCK_SIZE);
> > +             aes_encrypt(&k, (u8 *)&ctr, keystream);
> > +             xor(dst, keystream, src, nbytes % AES_BLOCK_SIZE);
> > +     }
> > +}
>
> This can be simplified quite a bit, for example:
>
> static void aes_256_xctr_crypt(const u8 key[AES_256_KEY_SIZE],
>                                const u8 iv[AES_BLOCK_SIZE], const u8 *src,
>                                u8 *dst, size_t nbytes)
> {
>         struct aes_key k;
>         union {
>                 u8 bytes[AES_BLOCK_SIZE];
>                 __le64 ctr;
>         } blk;
>         size_t i;
>
>         aes_setkey(&k, key, AES_256_KEY_SIZE);
>
>         for (i = 0; i < nbytes; i += AES_BLOCK_SIZE) {
>                 memcpy(blk.bytes, iv, AES_BLOCK_SIZE);
>                 blk.ctr ^= cpu_to_le64(1 + (i / AES_BLOCK_SIZE));
>                 aes_encrypt(&k, blk.bytes, blk.bytes);
>                 xor(&dst[i], blk.bytes, &src[i],
>                     MIN(AES_BLOCK_SIZE, nbytes - i));
>         }
> }
>
> We are not trying to micro-optimize for performance here, so it is fine to have
> the MIN() in the loop.
>
> Also note that 'i' needs to be size_t, not int.
>
> > +#define HCTR2_IV_SIZE 32
> > +static void aes_256_hctr2_crypt(const u8 key[AES_256_KEY_SIZE],
> > +                             const u8 iv[HCTR2_IV_SIZE], const u8 *src,
> > +                             u8 *dst, size_t nbytes, bool decrypting)
> > +{
> > +     be128 digest;
> > +     u8 MM[AES_BLOCK_SIZE];
> > +     u8 UU[AES_BLOCK_SIZE];
> > +     u8 S[AES_BLOCK_SIZE];
> > +     u8 hbar[AES_BLOCK_SIZE];
> > +     u8 L[AES_BLOCK_SIZE];
> > +     u8 padded_block[POLYVAL_BLOCK_SIZE];
> > +     const u8 *M = src;
> > +     const u8 *N = src + AES_BLOCK_SIZE;
> > +     u8 *U = dst;
> > +     u8 *V = dst + AES_BLOCK_SIZE;
> > +     int bulk_bytes = nbytes - AES_BLOCK_SIZE;
> > +     int remainder = bulk_bytes % AES_BLOCK_SIZE;
> > +     struct aes_key k;
> > +     le128 tweak_block;
>
> There are a lot variables in this function.  To make it easier to read, please
> try to declare them in the order they are used.
>
> bulk_bytes and remainder should be size_t.
>
> > +
> > +     memset(hbar, 0, AES_BLOCK_SIZE);
> > +     memset(L, 0, AES_BLOCK_SIZE);
> > +     L[0] = 0x01;
>
> The above can be replaced with initializers at declaration time:
>
>         u8 hbar[AES_BLOCK_SIZE] = { 0 };
>         u8 L[AES_BLOCK_SIZE] = { 1 };
>
> > +     aes_setkey(&k, key, AES_256_KEY_SIZE);
> > +     aes_encrypt(&k, hbar, hbar);
> > +     aes_encrypt(&k, L, L);
> > +
> > +     tweak_block.hi = 0;
> > +     tweak_block.lo = cpu_to_le64(remainder ? (HCTR2_IV_SIZE * 8 * 2 + 3) :
> > +             (HCTR2_IV_SIZE * 8 * 2 + 2));
>
> Similarly for tweak_block, which really should be called something like
> 'tweaklen_blk':
>
>         le128 tweaklen_blk = {
>                 .lo = cpu_to_le64(HCTR2_IV_SIZE * 8 * 2 + 2 + (remainder != 0)),
>         };
>
> > +     memset(&digest, 0, sizeof(digest));
> > +     polyval(hbar, (u8 *)&tweak_block, POLYVAL_BLOCK_SIZE, &digest);
> > +     polyval(hbar, iv, HCTR2_IV_SIZE, &digest);
> > +
> > +     if (remainder == 0) {
> > +             polyval(hbar, N, bulk_bytes, &digest);
> > +     } else {
> > +             polyval(hbar, N, bulk_bytes - remainder, &digest);
>
> If the 'polyval(hbar, N, bulk_bytes - remainder, &digest);' is moved above the
> 'if', then the 'remainder == 0' branch will be unneeded.  Likewise later on.
>
> > +static void aes_256_hctr2_encrypt(const u8 key[AES_256_KEY_SIZE],
> > +                             const u8 iv[HCTR2_IV_SIZE], const u8 *src,
> > +                             u8 *dst, size_t nbytes)
>
> Continuation lines should be properly aligned.
>
> > +#ifdef ENABLE_ALG_TESTS
> > +#include <linux/if_alg.h>
> > +#include <sys/socket.h>
> > +static void test_aes_256_hctr2(void)
> > +{
> > +     int algfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
> > +     struct sockaddr_alg addr = {
> > +             .salg_type = "skcipher",
> > +             .salg_name = "hctr2(aes)",
> > +     };
> > +     unsigned long num_tests = NUM_ALG_TEST_ITERATIONS;
> > +
> > +     if (algfd < 0)
> > +             die_errno("can't create AF_ALG socket");
> > +     if (bind(algfd, (struct sockaddr *)&addr, sizeof(addr)) != 0)
> > +             die_errno("can't bind AF_ALG socket to HCTR2 algorithm");
> > +
> > +     while (num_tests--) {
> > +             u8 key[AES_256_KEY_SIZE];
> > +             u8 iv[HCTR2_IV_SIZE];
> > +             u8 ptext[4096];
> > +             u8 ctext[sizeof(ptext)];
> > +             u8 ref_ctext[sizeof(ptext)];
> > +             u8 decrypted[sizeof(ptext)];
> > +             const size_t datalen = 16;
>
> This is only testing 16-byte data lengths.  It should be testing random data
> lengths >= 16 bytes and <= the array size above.
>
> > diff --git a/tests/generic/678 b/tests/generic/678
> > new file mode 100755
> > index 00000000..143e93f0
> > --- /dev/null
> > +++ b/tests/generic/678
> > @@ -0,0 +1,24 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright 2022 Google LLC
> > +#
> > +# FS QA Test No. 678
> > +#
> > +# Verify ciphertext for v1 encryption policies that use AES-256-XTS to encrypt
> > +# file contents and AES-256-HCTR2 to encrypt file names.
>
> I think we shouldn't add any new features to v1 encryption policies, as they are
> deprecated in favor of v2.
>
> So the kernel shouldn't allow this case, which would make this test unnecessary.
>
> - Eric
