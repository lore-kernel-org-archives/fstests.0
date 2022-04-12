Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BA0C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Apr 2022 19:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiDLT4o (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Apr 2022 15:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiDLTzc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Apr 2022 15:55:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9641769CE9
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 12:48:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d7eaa730d9so166831317b3.13
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 12:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FGZ9j/efAH0SMPKr5eTWPFDVdTmscEzmcaZFjRft4Ag=;
        b=Wk1AMy2Hs7R8Np9SNuZuW0yj89HMcvtQ1xjEY8Bo0Nc4LUn6E8b+4cunv2epniE6LB
         K3T6MT5Mys0XCrw6dMb1vm66jTT9cXke8mgVX+0fNEdgpcke8oI+ZxzZU7OO9u55OPlY
         FTaBpiYOn3SImsV9btS9hJ913lnjp2RER9NHyGBD3yd2RB5YCKXpqVPNO791jf8hCTyZ
         w8U/d3wPrSr1U9JgaYi9IygymjOmgfZZeltssYdM2Fm46a92LVZD/UhVkpkUSUIuSeBh
         G9abHcGsnn33RrVxCvy3MiMcUskzfAz0VNHc9Z1rwtEkUptbLGWR1urJnpYUm/Eh6dfF
         3P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FGZ9j/efAH0SMPKr5eTWPFDVdTmscEzmcaZFjRft4Ag=;
        b=jpCQ/lfWO3bp8lGwzLLrgOaI3vnujFI1BWjXtk063SMDSZWMhhCyc5mcn5JIS5uZBp
         dE9ckpNznnxDyoAncK2AxgZc8RpsrmCnffcJOOCxMAj/4Ju7q4C4cuLGM0k10JZTf+X8
         A7/7JIoScy7Y9JNf37CWcTM2OW02+qI5U+UmB6AV5qEddMDh8l64eukbo3u8BnEf1yuh
         pueNcmXIQEmcVAQBoAHUfpaQ+5ulLLVovfZZ+bVcLq1Y0828aIg6hkdZ4gLiVIYshpCg
         FMMV/jzDhz8TAaZj83O52WM31sz9mCqMyIfFgoq33UWA0WEnBA5CjbDy2rQMKlZIFT4s
         8xQA==
X-Gm-Message-State: AOAM53121gEd0b3ALUXCCTZ1FX7EYedLpeAM1DuDPMZlyfYPisxbNkP1
        ovNfpfKmVhCtp0jHbGteN8C2ix7+ei3rNS9N0jr7H+DoY3x0rTst8KsL2lSvTHfiDOE7fGeVtBQ
        H/oZSH0h6hE0pq1k3Y3UM68bbHMSwy8ZKguqZXqZkDNWTzzVxuDm08Mfqh8BM
X-Google-Smtp-Source: ABdhPJxpJ0qUxmbfW2g4jcKt6/8OyYYgA7Ai2b6TFZ8tEC++bAG3elneoejZLjG5YuOQpSvp9LmyAAytfQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:4055:0:b0:641:636e:18dd with SMTP id
 n82-20020a254055000000b00641636e18ddmr8147805yba.389.1649792914512; Tue, 12
 Apr 2022 12:48:34 -0700 (PDT)
Date:   Tue, 12 Apr 2022 14:48:07 -0500
Message-Id: <20220412194807.617356-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [RFC PATCH] fscrypt-crypt-util: add HCTR2 tests
From:   Nathan Huckleberry <nhuck@google.com>
To:     fstests@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patch is not intended to be accepted yet.  It is reliant on HCTR2
support in the kernel which has not yet been accepted.  See the HCTR2
patch here:
https://lore.kernel.org/all/20220412172816.917723-1-nhuck@google.com/

HCTR2 is a new wide-block encryption mode that can used for filename
encryption in fscrypt.  This patch adds tests for fscrypt policies using
HCTR2 for filename encryption.

More information on HCTR2 can be found here:
Length-preserving encryption with HCTR2
https://ia.cr/2021/1441

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 common/encrypt           |   2 +
 src/fscrypt-crypt-util.c | 452 ++++++++++++++++++++++++++++++++++-----
 tests/generic/678        |  24 +++
 tests/generic/678.out    |   5 +
 tests/generic/679        |  26 +++
 tests/generic/679.out    |   6 +
 tests/generic/680        |  26 +++
 tests/generic/680.out    |   6 +
 tests/generic/681        |  26 +++
 tests/generic/681.out    |   6 +
 10 files changed, 523 insertions(+), 56 deletions(-)
 create mode 100755 tests/generic/678
 create mode 100644 tests/generic/678.out
 create mode 100755 tests/generic/679
 create mode 100644 tests/generic/679.out
 create mode 100755 tests/generic/680
 create mode 100644 tests/generic/680.out
 create mode 100755 tests/generic/681
 create mode 100644 tests/generic/681.out

diff --git a/common/encrypt b/common/encrypt
index f90c4ef0..937bb914 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -767,6 +767,7 @@ FSCRYPT_MODE_AES_256_CTS=4
 FSCRYPT_MODE_AES_128_CBC=5
 FSCRYPT_MODE_AES_128_CTS=6
 FSCRYPT_MODE_ADIANTUM=9
+FSCRYPT_MODE_AES_256_HCTR2=10
 
 FSCRYPT_POLICY_FLAG_DIRECT_KEY=0x04
 FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64=0x08
@@ -785,6 +786,7 @@ _fscrypt_mode_name_to_num()
 	AES-128-CBC-ESSIV)	echo $FSCRYPT_MODE_AES_128_CBC ;;
 	AES-128-CTS-CBC)	echo $FSCRYPT_MODE_AES_128_CTS ;;
 	Adiantum)		echo $FSCRYPT_MODE_ADIANTUM ;;
+	AES-256-HCTR2)		echo $FSCRYPT_MODE_AES_256_HCTR2 ;;
 	*)			_fail "Unknown fscrypt mode: $name" ;;
 	esac
 }
diff --git a/src/fscrypt-crypt-util.c b/src/fscrypt-crypt-util.c
index 03cc3c4a..93ab017d 100644
--- a/src/fscrypt-crypt-util.c
+++ b/src/fscrypt-crypt-util.c
@@ -37,7 +37,8 @@
 /*
  * Define to enable the tests of the crypto code in this file.  If enabled, you
  * must link this program with OpenSSL (-lcrypto) v1.1.0 or later, and your
- * kernel needs CONFIG_CRYPTO_USER_API_SKCIPHER=y and CONFIG_CRYPTO_ADIANTUM=y.
+ * kernel needs CONFIG_CRYPTO_USER_API_SKCIPHER=y, CONFIG_CRYPTO_ADIANTUM=y, and
+ * CONFIG_CRYPTO_HCTR2=y.
  */
 #undef ENABLE_ALG_TESTS
 
@@ -54,7 +55,8 @@ static void usage(FILE *fp)
 "resulting ciphertext (or plaintext) to stdout.\n"
 "\n"
 "CIPHER can be AES-256-XTS, AES-256-CTS-CBC, AES-128-CBC-ESSIV, AES-128-CTS-CBC,\n"
-"or Adiantum.  MASTER_KEY must be a hex string long enough for the cipher.\n"
+"Adiantum, or AES-256-HCTR2.  MASTER_KEY must be a hex string long enough for\n"
+"the cipher."
 "\n"
 "WARNING: this program is only meant for testing, not for \"real\" use!\n"
 "\n"
@@ -268,12 +270,115 @@ static void rand_bytes(u8 *buf, size_t count)
 	while (count--)
 		*buf++ = rand();
 }
+
+#include <linux/if_alg.h>
+#include <sys/socket.h>
+#define SOL_ALG 279
+static void af_alg_crypt(int algfd, int op, const u8 *key, size_t keylen,
+			 const u8 *iv, size_t ivlen,
+			 const u8 *src, u8 *dst, size_t datalen)
+{
+	size_t controllen = CMSG_SPACE(sizeof(int)) +
+			    CMSG_SPACE(sizeof(struct af_alg_iv) + ivlen);
+	u8 *control = xmalloc(controllen);
+	struct iovec iov = { .iov_base = (u8 *)src, .iov_len = datalen };
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = control,
+		.msg_controllen = controllen,
+	};
+	struct cmsghdr *cmsg;
+	struct af_alg_iv *algiv;
+	int reqfd;
+
+	memset(control, 0, controllen);
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+	cmsg->cmsg_level = SOL_ALG;
+	cmsg->cmsg_type = ALG_SET_OP;
+	*(int *)CMSG_DATA(cmsg) = op;
+
+	cmsg = CMSG_NXTHDR(&msg, cmsg);
+	cmsg->cmsg_len = CMSG_LEN(sizeof(struct af_alg_iv) + ivlen);
+	cmsg->cmsg_level = SOL_ALG;
+	cmsg->cmsg_type = ALG_SET_IV;
+	algiv = (struct af_alg_iv *)CMSG_DATA(cmsg);
+	algiv->ivlen = ivlen;
+	memcpy(algiv->iv, iv, ivlen);
+
+	if (setsockopt(algfd, SOL_ALG, ALG_SET_KEY, key, keylen) != 0)
+		die_errno("can't set key on AF_ALG socket");
+
+	reqfd = accept(algfd, NULL, NULL);
+	if (reqfd < 0)
+		die_errno("can't accept() AF_ALG socket");
+	if (sendmsg(reqfd, &msg, 0) != datalen)
+		die_errno("can'datalen, t sendmsg() AF_ALG request socket");
+	if (xread(reqfd, dst, datalen) != datalen)
+		die("short read from AF_ALG request socket");
+	close(reqfd);
+
+	free(control);
+}
 #endif
 
 /*----------------------------------------------------------------------------*
  *                          Finite field arithmetic                           *
  *----------------------------------------------------------------------------*/
 
+#define gf128mul_dat(q) { \
+	q(0x00), q(0x01), q(0x02), q(0x03), q(0x04), q(0x05), q(0x06), q(0x07),\
+	q(0x08), q(0x09), q(0x0a), q(0x0b), q(0x0c), q(0x0d), q(0x0e), q(0x0f),\
+	q(0x10), q(0x11), q(0x12), q(0x13), q(0x14), q(0x15), q(0x16), q(0x17),\
+	q(0x18), q(0x19), q(0x1a), q(0x1b), q(0x1c), q(0x1d), q(0x1e), q(0x1f),\
+	q(0x20), q(0x21), q(0x22), q(0x23), q(0x24), q(0x25), q(0x26), q(0x27),\
+	q(0x28), q(0x29), q(0x2a), q(0x2b), q(0x2c), q(0x2d), q(0x2e), q(0x2f),\
+	q(0x30), q(0x31), q(0x32), q(0x33), q(0x34), q(0x35), q(0x36), q(0x37),\
+	q(0x38), q(0x39), q(0x3a), q(0x3b), q(0x3c), q(0x3d), q(0x3e), q(0x3f),\
+	q(0x40), q(0x41), q(0x42), q(0x43), q(0x44), q(0x45), q(0x46), q(0x47),\
+	q(0x48), q(0x49), q(0x4a), q(0x4b), q(0x4c), q(0x4d), q(0x4e), q(0x4f),\
+	q(0x50), q(0x51), q(0x52), q(0x53), q(0x54), q(0x55), q(0x56), q(0x57),\
+	q(0x58), q(0x59), q(0x5a), q(0x5b), q(0x5c), q(0x5d), q(0x5e), q(0x5f),\
+	q(0x60), q(0x61), q(0x62), q(0x63), q(0x64), q(0x65), q(0x66), q(0x67),\
+	q(0x68), q(0x69), q(0x6a), q(0x6b), q(0x6c), q(0x6d), q(0x6e), q(0x6f),\
+	q(0x70), q(0x71), q(0x72), q(0x73), q(0x74), q(0x75), q(0x76), q(0x77),\
+	q(0x78), q(0x79), q(0x7a), q(0x7b), q(0x7c), q(0x7d), q(0x7e), q(0x7f),\
+	q(0x80), q(0x81), q(0x82), q(0x83), q(0x84), q(0x85), q(0x86), q(0x87),\
+	q(0x88), q(0x89), q(0x8a), q(0x8b), q(0x8c), q(0x8d), q(0x8e), q(0x8f),\
+	q(0x90), q(0x91), q(0x92), q(0x93), q(0x94), q(0x95), q(0x96), q(0x97),\
+	q(0x98), q(0x99), q(0x9a), q(0x9b), q(0x9c), q(0x9d), q(0x9e), q(0x9f),\
+	q(0xa0), q(0xa1), q(0xa2), q(0xa3), q(0xa4), q(0xa5), q(0xa6), q(0xa7),\
+	q(0xa8), q(0xa9), q(0xaa), q(0xab), q(0xac), q(0xad), q(0xae), q(0xaf),\
+	q(0xb0), q(0xb1), q(0xb2), q(0xb3), q(0xb4), q(0xb5), q(0xb6), q(0xb7),\
+	q(0xb8), q(0xb9), q(0xba), q(0xbb), q(0xbc), q(0xbd), q(0xbe), q(0xbf),\
+	q(0xc0), q(0xc1), q(0xc2), q(0xc3), q(0xc4), q(0xc5), q(0xc6), q(0xc7),\
+	q(0xc8), q(0xc9), q(0xca), q(0xcb), q(0xcc), q(0xcd), q(0xce), q(0xcf),\
+	q(0xd0), q(0xd1), q(0xd2), q(0xd3), q(0xd4), q(0xd5), q(0xd6), q(0xd7),\
+	q(0xd8), q(0xd9), q(0xda), q(0xdb), q(0xdc), q(0xdd), q(0xde), q(0xdf),\
+	q(0xe0), q(0xe1), q(0xe2), q(0xe3), q(0xe4), q(0xe5), q(0xe6), q(0xe7),\
+	q(0xe8), q(0xe9), q(0xea), q(0xeb), q(0xec), q(0xed), q(0xee), q(0xef),\
+	q(0xf0), q(0xf1), q(0xf2), q(0xf3), q(0xf4), q(0xf5), q(0xf6), q(0xf7),\
+	q(0xf8), q(0xf9), q(0xfa), q(0xfb), q(0xfc), q(0xfd), q(0xfe), q(0xff) \
+}
+
+#define xda_be(i) ( \
+	(i & 0x80 ? 0x4380 : 0) ^ (i & 0x40 ? 0x21c0 : 0) ^ \
+	(i & 0x20 ? 0x10e0 : 0) ^ (i & 0x10 ? 0x0870 : 0) ^ \
+	(i & 0x08 ? 0x0438 : 0) ^ (i & 0x04 ? 0x021c : 0) ^ \
+	(i & 0x02 ? 0x010e : 0) ^ (i & 0x01 ? 0x0087 : 0) \
+)
+
+#define xda_le(i) ( \
+	(i & 0x80 ? 0xe100 : 0) ^ (i & 0x40 ? 0x7080 : 0) ^ \
+	(i & 0x20 ? 0x3840 : 0) ^ (i & 0x10 ? 0x1c20 : 0) ^ \
+	(i & 0x08 ? 0x0e10 : 0) ^ (i & 0x04 ? 0x0708 : 0) ^ \
+	(i & 0x02 ? 0x0384 : 0) ^ (i & 0x01 ? 0x01c2 : 0) \
+)
+
+static const u16 gf2_128_mul_table_le[256] = gf128mul_dat(xda_le);
+
 /* Multiply a GF(2^8) element by the polynomial 'x' */
 static inline u8 gf2_8_mul_x(u8 b)
 {
@@ -292,8 +397,13 @@ typedef struct {
 	__le64 hi;
 } ble128;
 
+typedef struct {
+	__le64 hi;
+	__le64 lo;
+} be128;
+
 /* Multiply a GF(2^128) element by the polynomial 'x' */
-static inline void gf2_128_mul_x(ble128 *t)
+static inline void gf2_128_mul_x_ble(ble128 *t)
 {
 	u64 lo = le64_to_cpu(t->lo);
 	u64 hi = le64_to_cpu(t->hi);
@@ -302,6 +412,66 @@ static inline void gf2_128_mul_x(ble128 *t)
 	t->lo = cpu_to_le64((lo << 1) ^ ((hi & (1ULL << 63)) ? 0x87 : 0));
 }
 
+static inline void gf2_128_mul_x_lle(be128 *t)
+{
+	u64 hi = be64_to_cpu(t->hi);
+	u64 lo = be64_to_cpu(t->lo);
+
+	u64 _tt = (lo & (1ULL)) ? ((u64)0xe1 << 56) : 0;
+
+	t->lo = cpu_to_be64((lo >> 1) | (hi << 63));
+	t->hi = cpu_to_be64((hi >> 1) ^ _tt);
+}
+
+static inline void gf2_128_mul_x8_lle(be128 *t)
+{
+	u64 hi = be64_to_cpu(t->hi);
+	u64 lo = be64_to_cpu(t->lo);
+	u64 _tt = gf2_128_mul_table_le[lo & 0xff];
+
+	t->lo = cpu_to_be64((lo >> 8) | (hi << 56));
+	t->hi = cpu_to_be64((hi >> 8) ^ (_tt << 48));
+}
+
+void gf2_128_mul_lle(be128 *r, const be128 *b)
+{
+	be128 p[8];
+	int i;
+
+	p[0] = *r;
+	for (i = 0; i < 7; ++i) {
+		memcpy(&p[i + 1], &p[i], sizeof(be128));
+		gf2_128_mul_x_lle(&p[i + 1]);
+	}
+
+	memset(r, 0, sizeof(*r));
+	for (i = 0;;) {
+		u8 ch = ((u8 *)b)[15-i];
+
+		if (ch & 0x80)
+			xor((u8 *)r, (u8 *)r, (u8 *)&p[0], sizeof(*r));
+		if (ch & 0x40)
+			xor((u8 *)r, (u8 *)r, (u8 *)&p[1], sizeof(*r));
+		if (ch & 0x20)
+			xor((u8 *)r, (u8 *)r, (u8 *)&p[2], sizeof(*r));
+		if (ch & 0x10)
+			xor((u8 *)r, (u8 *)r, (u8 *)&p[3], sizeof(*r));
+		if (ch & 0x08)
+			xor((u8 *)r, (u8 *)r, (u8 *)&p[4], sizeof(*r));
+		if (ch & 0x04)
+			xor((u8 *)r, (u8 *)r, (u8 *)&p[5], sizeof(*r));
+		if (ch & 0x02)
+			xor((u8 *)r, (u8 *)r, (u8 *)&p[6], sizeof(*r));
+		if (ch & 0x01)
+			xor((u8 *)r, (u8 *)r, (u8 *)&p[7], sizeof(*r));
+
+		if (++i >= 16)
+			break;
+
+		gf2_128_mul_x8_lle(r);
+	}
+}
+
 /*----------------------------------------------------------------------------*
  *                             Group arithmetic                               *
  *----------------------------------------------------------------------------*/
@@ -901,6 +1071,54 @@ static void test_hkdf_sha512(void)
 }
 #endif /* ENABLE_ALG_TESTS */
 
+/*----------------------------------------------------------------------------*
+ *                                 POLVAL                                     *
+ *----------------------------------------------------------------------------*/
+
+#define POLYVAL_KEY_SIZE	16
+#define POLYVAL_BLOCK_SIZE	16
+
+static void reverse_bytes(be128 *a)
+{
+	__le64 tmp = a->lo;
+
+	a->lo = a->hi;
+	a->hi = tmp;
+	a->lo = __builtin_bswap64(a->lo);
+	a->hi = __builtin_bswap64(a->hi);
+}
+
+static void polyval(const u8 key[POLYVAL_KEY_SIZE],
+		    const u8 *msg, size_t msglen, be128 *out)
+{
+	be128 h;
+	be128 tmp;
+	int nblocks = msglen / POLYVAL_BLOCK_SIZE;
+	int tail = msglen % POLYVAL_BLOCK_SIZE;
+
+	reverse_bytes(out);
+	memcpy(&h, key, sizeof(h));
+	reverse_bytes(&h);
+	gf2_128_mul_x_lle(&h);
+
+	while (nblocks > 0) {
+		memcpy(&tmp, msg, sizeof(tmp));
+		reverse_bytes(&tmp);
+		xor((u8 *)out, (u8 *)out, (u8 *)&tmp, sizeof(tmp));
+		gf2_128_mul_lle(out, &h);
+		msg += POLYVAL_BLOCK_SIZE;
+		nblocks--;
+	}
+	if (tail) {
+		memset(&tmp, 0, POLYVAL_BLOCK_SIZE);
+		memcpy(&tmp, msg, tail);
+		reverse_bytes(&tmp);
+		xor((u8 *)out, (u8 *)out, (u8 *)&tmp, sizeof(tmp));
+		gf2_128_mul_lle(out, &h);
+	}
+	reverse_bytes(out);
+}
+
 /*----------------------------------------------------------------------------*
  *                            AES encryption modes                            *
  *----------------------------------------------------------------------------*/
@@ -924,7 +1142,7 @@ static void aes_256_xts_crypt(const u8 key[2 * AES_256_KEY_SIZE],
 		else
 			aes_encrypt(&cipher_key, &dst[i], &dst[i]);
 		xor(&dst[i], &dst[i], (const u8 *)&t, AES_BLOCK_SIZE);
-		gf2_128_mul_x(&t);
+		gf2_128_mul_x_ble(&t);
 	}
 }
 
@@ -1173,6 +1391,173 @@ static void aes_128_cts_cbc_decrypt(const u8 key[AES_128_KEY_SIZE],
 	aes_cts_cbc_decrypt(key, AES_128_KEY_SIZE, iv, src, dst, nbytes);
 }
 
+static void aes_256_xctr_crypt(const u8 key[AES_256_KEY_SIZE],
+			      const u8 iv[AES_BLOCK_SIZE], const u8 *src,
+			      u8 *dst, size_t nbytes)
+{
+	struct aes_key k;
+	int i;
+	int nblocks;
+	le128 ctr;
+	u8 keystream[AES_BLOCK_SIZE];
+
+	aes_setkey(&k, key, AES_256_KEY_SIZE);
+
+	nblocks = nbytes / AES_BLOCK_SIZE;
+	for (i = 0; i < nblocks; i++) {
+		ctr.hi = 0;
+		ctr.lo = cpu_to_le64(i + 1);
+		xor((u8 *)&ctr, (u8 *)&ctr, iv, AES_BLOCK_SIZE);
+		aes_encrypt(&k, (u8 *)&ctr, keystream);
+		xor(dst, keystream, src, AES_BLOCK_SIZE);
+		src += AES_BLOCK_SIZE;
+		dst += AES_BLOCK_SIZE;
+	}
+
+	if (nbytes % AES_BLOCK_SIZE != 0) {
+		ctr.hi = 0;
+		ctr.lo = cpu_to_le64(nbytes / AES_BLOCK_SIZE + 1);
+		xor((u8 *)&ctr, (u8 *)&ctr, iv, AES_BLOCK_SIZE);
+		aes_encrypt(&k, (u8 *)&ctr, keystream);
+		xor(dst, keystream, src, nbytes % AES_BLOCK_SIZE);
+	}
+}
+
+#define HCTR2_IV_SIZE 32
+static void aes_256_hctr2_crypt(const u8 key[AES_256_KEY_SIZE],
+				const u8 iv[HCTR2_IV_SIZE], const u8 *src,
+				u8 *dst, size_t nbytes, bool decrypting)
+{
+	be128 digest;
+	u8 MM[AES_BLOCK_SIZE];
+	u8 UU[AES_BLOCK_SIZE];
+	u8 S[AES_BLOCK_SIZE];
+	u8 hbar[AES_BLOCK_SIZE];
+	u8 L[AES_BLOCK_SIZE];
+	u8 padded_block[POLYVAL_BLOCK_SIZE];
+	const u8 *M = src;
+	const u8 *N = src + AES_BLOCK_SIZE;
+	u8 *U = dst;
+	u8 *V = dst + AES_BLOCK_SIZE;
+	int bulk_bytes = nbytes - AES_BLOCK_SIZE;
+	int remainder = bulk_bytes % AES_BLOCK_SIZE;
+	struct aes_key k;
+	le128 tweak_block;
+
+	ASSERT(nbytes >= AES_BLOCK_SIZE);
+
+	memset(hbar, 0, AES_BLOCK_SIZE);
+	memset(L, 0, AES_BLOCK_SIZE);
+	L[0] = 0x01;
+	aes_setkey(&k, key, AES_256_KEY_SIZE);
+	aes_encrypt(&k, hbar, hbar);
+	aes_encrypt(&k, L, L);
+
+	tweak_block.hi = 0;
+	tweak_block.lo = cpu_to_le64(remainder ? (HCTR2_IV_SIZE * 8 * 2 + 3) :
+		(HCTR2_IV_SIZE * 8 * 2 + 2));
+	memset(&digest, 0, sizeof(digest));
+	polyval(hbar, (u8 *)&tweak_block, POLYVAL_BLOCK_SIZE, &digest);
+	polyval(hbar, iv, HCTR2_IV_SIZE, &digest);
+
+	if (remainder == 0) {
+		polyval(hbar, N, bulk_bytes, &digest);
+	} else {
+		polyval(hbar, N, bulk_bytes - remainder, &digest);
+		memset(padded_block, 0, POLYVAL_BLOCK_SIZE);
+		memcpy(padded_block, N + bulk_bytes - remainder, remainder);
+		padded_block[remainder] = 0x01;
+		polyval(hbar, padded_block, POLYVAL_BLOCK_SIZE, &digest);
+	}
+
+	xor(MM, M, (u8 *)&digest, AES_BLOCK_SIZE);
+
+	if (decrypting)
+		aes_decrypt(&k, MM, UU);
+	else
+		aes_encrypt(&k, MM, UU);
+
+	xor(S, MM, UU, AES_BLOCK_SIZE);
+	xor(S, L, S, AES_BLOCK_SIZE);
+
+	aes_256_xctr_crypt(key, S, N, V, bulk_bytes);
+
+	memset(&digest, 0, sizeof(digest));
+	polyval(hbar, (u8 *)&tweak_block, POLYVAL_BLOCK_SIZE, &digest);
+	polyval(hbar, iv, HCTR2_IV_SIZE, &digest);
+
+	if (remainder == 0) {
+		polyval(hbar, V, bulk_bytes, &digest);
+	} else {
+		polyval(hbar, V, bulk_bytes - remainder, &digest);
+		memset(padded_block, 0, POLYVAL_BLOCK_SIZE);
+		memcpy(padded_block, V + bulk_bytes - remainder, remainder);
+		padded_block[remainder] = 0x01;
+		polyval(hbar, padded_block, POLYVAL_BLOCK_SIZE, &digest);
+	}
+
+	xor(U, UU, (u8 *)&digest, AES_BLOCK_SIZE);
+}
+
+static void aes_256_hctr2_encrypt(const u8 key[AES_256_KEY_SIZE],
+				const u8 iv[HCTR2_IV_SIZE], const u8 *src,
+				u8 *dst, size_t nbytes)
+{
+	aes_256_hctr2_crypt(key, iv, src, dst, nbytes, false);
+}
+
+static void aes_256_hctr2_decrypt(const u8 key[AES_256_KEY_SIZE],
+				const u8 iv[HCTR2_IV_SIZE], const u8 *src,
+				u8 *dst, size_t nbytes)
+{
+	aes_256_hctr2_crypt(key, iv, src, dst, nbytes, true);
+}
+
+#ifdef ENABLE_ALG_TESTS
+#include <linux/if_alg.h>
+#include <sys/socket.h>
+static void test_aes_256_hctr2(void)
+{
+	int algfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
+	struct sockaddr_alg addr = {
+		.salg_type = "skcipher",
+		.salg_name = "hctr2(aes)",
+	};
+	unsigned long num_tests = NUM_ALG_TEST_ITERATIONS;
+
+	if (algfd < 0)
+		die_errno("can't create AF_ALG socket");
+	if (bind(algfd, (struct sockaddr *)&addr, sizeof(addr)) != 0)
+		die_errno("can't bind AF_ALG socket to HCTR2 algorithm");
+
+	while (num_tests--) {
+		u8 key[AES_256_KEY_SIZE];
+		u8 iv[HCTR2_IV_SIZE];
+		u8 ptext[4096];
+		u8 ctext[sizeof(ptext)];
+		u8 ref_ctext[sizeof(ptext)];
+		u8 decrypted[sizeof(ptext)];
+		const size_t datalen = 16;
+
+		rand_bytes(key, sizeof(key));
+		rand_bytes(iv, sizeof(iv));
+		rand_bytes(ptext, datalen);
+		memset(key, 0, sizeof(key));
+		memset(iv, 0, sizeof(iv));
+		memset(ptext, 0, datalen);
+
+		aes_256_hctr2_encrypt(key, iv, ptext, ctext, datalen);
+		af_alg_crypt(algfd, ALG_OP_ENCRYPT, key, sizeof(key),
+			     iv, sizeof(iv), ptext, ref_ctext, datalen);
+		ASSERT(memcmp(ctext, ref_ctext, datalen) == 0);
+
+		aes_256_hctr2_decrypt(key, iv, ctext, decrypted, datalen);
+		ASSERT(memcmp(ptext, decrypted, datalen) == 0);
+	}
+	close(algfd);
+}
+#endif /* ENABLE_ALG_TESTS */
+
 /*----------------------------------------------------------------------------*
  *                           XChaCha12 stream cipher                          *
  *----------------------------------------------------------------------------*/
@@ -1500,58 +1885,6 @@ static void adiantum_decrypt(const u8 key[ADIANTUM_KEY_SIZE],
 }
 
 #ifdef ENABLE_ALG_TESTS
-#include <linux/if_alg.h>
-#include <sys/socket.h>
-#define SOL_ALG 279
-static void af_alg_crypt(int algfd, int op, const u8 *key, size_t keylen,
-			 const u8 *iv, size_t ivlen,
-			 const u8 *src, u8 *dst, size_t datalen)
-{
-	size_t controllen = CMSG_SPACE(sizeof(int)) +
-			    CMSG_SPACE(sizeof(struct af_alg_iv) + ivlen);
-	u8 *control = xmalloc(controllen);
-	struct iovec iov = { .iov_base = (u8 *)src, .iov_len = datalen };
-	struct msghdr msg = {
-		.msg_iov = &iov,
-		.msg_iovlen = 1,
-		.msg_control = control,
-		.msg_controllen = controllen,
-	};
-	struct cmsghdr *cmsg;
-	struct af_alg_iv *algiv;
-	int reqfd;
-
-	memset(control, 0, controllen);
-
-	cmsg = CMSG_FIRSTHDR(&msg);
-	cmsg->cmsg_len = CMSG_LEN(sizeof(int));
-	cmsg->cmsg_level = SOL_ALG;
-	cmsg->cmsg_type = ALG_SET_OP;
-	*(int *)CMSG_DATA(cmsg) = op;
-
-	cmsg = CMSG_NXTHDR(&msg, cmsg);
-	cmsg->cmsg_len = CMSG_LEN(sizeof(struct af_alg_iv) + ivlen);
-	cmsg->cmsg_level = SOL_ALG;
-	cmsg->cmsg_type = ALG_SET_IV;
-	algiv = (struct af_alg_iv *)CMSG_DATA(cmsg);
-	algiv->ivlen = ivlen;
-	memcpy(algiv->iv, iv, ivlen);
-
-	if (setsockopt(algfd, SOL_ALG, ALG_SET_KEY, key, keylen) != 0)
-		die_errno("can't set key on AF_ALG socket");
-
-	reqfd = accept(algfd, NULL, NULL);
-	if (reqfd < 0)
-		die_errno("can't accept() AF_ALG socket");
-	if (sendmsg(reqfd, &msg, 0) != datalen)
-		die_errno("can't sendmsg() AF_ALG request socket");
-	if (xread(reqfd, dst, datalen) != datalen)
-		die("short read from AF_ALG request socket");
-	close(reqfd);
-
-	free(control);
-}
-
 static void test_adiantum(void)
 {
 	int algfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
@@ -1675,6 +2008,12 @@ static const struct fscrypt_cipher {
 		.decrypt = aes_128_cts_cbc_decrypt,
 		.keysize = AES_128_KEY_SIZE,
 		.min_input_size = AES_BLOCK_SIZE,
+	}, {
+		.name = "AES-256-HCTR2",
+		.encrypt = aes_256_hctr2_encrypt,
+		.decrypt = aes_256_hctr2_decrypt,
+		.keysize = AES_256_KEY_SIZE,
+		.min_input_size = AES_BLOCK_SIZE,
 	}, {
 		.name = "Adiantum",
 		.encrypt = adiantum_encrypt,
@@ -1980,6 +2319,7 @@ int main(int argc, char *argv[])
 	test_aes_256_xts();
 	test_aes_256_cts_cbc();
 	test_adiantum();
+	test_aes_256_hctr2();
 #endif
 
 	while ((c = getopt_long(argc, argv, "", longopts, NULL)) != -1) {
diff --git a/tests/generic/678 b/tests/generic/678
new file mode 100755
index 00000000..143e93f0
--- /dev/null
+++ b/tests/generic/678
@@ -0,0 +1,24 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2022 Google LLC
+#
+# FS QA Test No. 678
+#
+# Verify ciphertext for v1 encryption policies that use AES-256-XTS to encrypt
+# file contents and AES-256-HCTR2 to encrypt file names.
+#
+. ./common/preamble
+_begin_fstest auto quick encrypt
+
+# Import common functions.
+. ./common/filter
+. ./common/encrypt
+
+# real QA test starts here
+_supported_fs generic
+
+_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-HCTR2
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/678.out b/tests/generic/678.out
new file mode 100644
index 00000000..22a4914d
--- /dev/null
+++ b/tests/generic/678.out
@@ -0,0 +1,5 @@
+QA output created by 678
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: AES-256-XTS
+	filenames_encryption_mode: AES-256-HCTR2
diff --git a/tests/generic/679 b/tests/generic/679
new file mode 100755
index 00000000..e7df379b
--- /dev/null
+++ b/tests/generic/679
@@ -0,0 +1,26 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2022 Google LLC
+#
+# FS QA Test No. generic/678
+#
+# Verify ciphertext for v2 encryption policies that use AES-256-XTS to encrypt
+# file contents and AES-256-HCTR2 to encrypt file names.
+#
+# This is the same as generic/678, except using v2 policies.
+#
+. ./common/preamble
+_begin_fstest auto quick encrypt
+
+# Import common functions.
+. ./common/filter
+. ./common/encrypt
+
+# real QA test starts here
+_supported_fs generic
+
+_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-HCTR2 v2
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/679.out b/tests/generic/679.out
new file mode 100644
index 00000000..079634f7
--- /dev/null
+++ b/tests/generic/679.out
@@ -0,0 +1,6 @@
+QA output created by 679
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: AES-256-XTS
+	filenames_encryption_mode: AES-256-HCTR2
+	options: v2
diff --git a/tests/generic/680 b/tests/generic/680
new file mode 100755
index 00000000..1db152b2
--- /dev/null
+++ b/tests/generic/680
@@ -0,0 +1,26 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2022 Google LLC
+#
+# FS QA Test No. 680
+#
+# Verify ciphertext for v2 encryption policies that use the IV_INO_LBLK_32 flag
+# and use AES-256-XTS to encrypt file contents and AES-256-HCTR2 to encrypt
+# file names.
+#
+. ./common/preamble
+_begin_fstest auto quick encrypt
+
+# Import common functions.
+. ./common/filter
+. ./common/encrypt
+
+# real QA test starts here
+_supported_fs generic
+
+_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-HCTR2 \
+	v2 iv_ino_lblk_32
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/680.out b/tests/generic/680.out
new file mode 100644
index 00000000..05291527
--- /dev/null
+++ b/tests/generic/680.out
@@ -0,0 +1,6 @@
+QA output created by 680
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: AES-256-XTS
+	filenames_encryption_mode: AES-256-HCTR2
+	options: v2 iv_ino_lblk_32
diff --git a/tests/generic/681 b/tests/generic/681
new file mode 100755
index 00000000..7a7d0a8f
--- /dev/null
+++ b/tests/generic/681
@@ -0,0 +1,26 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2022 Google LLC
+#
+# FS QA Test No. 681
+#
+# Verify ciphertext for v2 encryption policies that use the IV_INO_LBLK_64 flag
+# and use AES-256-XTS to encrypt file contents and AES-256-HCTR2 to encrypt
+# file names.
+#
+. ./common/preamble
+_begin_fstest auto quick encrypt
+
+# Import common functions.
+. ./common/filter
+. ./common/encrypt
+
+# real QA test starts here
+_supported_fs generic
+
+_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-HCTR2 \
+	v2 iv_ino_lblk_64
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/681.out b/tests/generic/681.out
new file mode 100644
index 00000000..0b4bd4ec
--- /dev/null
+++ b/tests/generic/681.out
@@ -0,0 +1,6 @@
+QA output created by 681
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: AES-256-XTS
+	filenames_encryption_mode: AES-256-HCTR2
+	options: v2 iv_ino_lblk_64
-- 
2.35.1.1178.g4f1659d476-goog

