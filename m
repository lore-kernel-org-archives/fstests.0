Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73D248F6E
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820283; cv=fail; b=GjznW2yQr1yacR4JYr5BUg3snwTW9h2drdE5vEZxxjnUDIQEZd1aKgNltIYpbcYpd1f9WA4WbOhVNbaioWcDR65SDgc6nJ04FQnNWYvYOOlVfRJJ/DeLKHDlKu5NKaNLfPGuPh7UwuViNKS6Ul+9tBAsm4yavb1TSRWLDUT5fUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820283; c=relaxed/simple;
	bh=8dM4ndJfzUBSKGHzRimH9JXX3ABVgAN7TA36V7KlRrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bx+aWkDCS4X0C/XYv7wGCv0wwa00ahZFPw4XkvHxujC7FbcRZTfTfauRRYSrlBjlvV6a35RD433JhYYo+NM1r0dbPxj12VC/KSb3+ZHV2WX/r5DskYqqHrlyilVu2z579tuIeZ1cXXYPKcQdB3xZhuVOZyb9YI6ZzGldaH22GBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cRVdEl48; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=z2fFOWDd; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cRVdEl48";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="z2fFOWDd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747820281; x=1779356281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8dM4ndJfzUBSKGHzRimH9JXX3ABVgAN7TA36V7KlRrA=;
  b=cRVdEl48csJ3VFF5kNFbgtf2bj75PzFaiLI0yqJ4rkJ4QrDBjp7rb+zA
   Sz1K58NxCW4K6Jq8P9X4fNfxKQxZk+MFXFrVvhL9Zi4Pq4Jlm/HFnmlYD
   iq+rFGl7TzdgVQRlQuPs+Kt+5LtI5VkvWjs47I4R3O1lFBIAat+pDSr00
   /KbPcgXY7wgQJPk7XOFD+S5XdTTvxYa08VtOoImovyzPJZiZjYzb44kyp
   ffRUMYdGQWW/veoKmkMiTDbL68utKwC/IwUa8FZLiogETTibizj4m3DDY
   e8IkMXchkz82uo9vD1tlY8mHUpXDGWvulhXtqu33a6wlVOQ/Vvob3RWBb
   A==;
X-CSE-ConnectionGUID: 1EmJXWNXRByN8mm+y8nIKQ==
X-CSE-MsgGUID: sUDryLGrQfeMRM66eT3LYA==
X-IronPort-AV: E=Sophos;i="6.15,303,1739808000"; 
   d="scan'208";a="82738208"
Received: from mail-southcentralusazlp17011024.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.24])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2025 17:37:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6ALqTtgNGBX+L8ngB4OGmwmi5KGE0ukb46xdT3FFKMc+ceaC9qrGpLK2aVRlT7iis0/KfrMpx1JCRhbBbL3SKQRVXjmoH4U/a0Nvy6ALzmxETdNt6bZPnD0Pt+MWVGqhNU346+8d4AuRzTMoSDpL3HLCqQ/LZG4eadNVx3WZNqWKzB/2ZhHnujdCBjUeE+Wza3vUAlfZ5N3QyKxBliWfONgKOuBO7bh2Wi3JRAsjZAPU0vq1T0oORUpBh7Hbto5TGt3ze95JlTe7w3mmiVMuFHZ1E8ANmoNejg+PmmkaNdnlbUE9mFIXYiw3MlQWKFeRisfnFBcmTrMsyyFEaFxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+569Qo7UyU7sffE7SA9kFX7dOF/0r09fe9zpSjLxQnI=;
 b=t2Rn9xYstJHTtEIYFtci/XONNrfq2XNQPiGPtbUniS/x4lkBZevRfpOtsS7iQMHbpFpR8RMgs/s0B47xq8qbeutv5oSgprbl+65We8he6Xbz1kEgwfke5Ur1SPqU00t4zrLHtH9Vndt2oU1uV+VkbB/2QklXd0H2jmgke+/ITAJEd4mW4CwxRYi6W+YXGSzojavy5IAlOqRui/Lx0YX6U79D5Us/N7fNSxmDNpsL6WDybmHdcvLXA6bV8fhWTkI2bxpLFUWhoqYFuLonI9hhQWPuJOla3JCly8lK7SE7580ewHhbWBrcT8T3My8wT6RKSGs/l4cuLIvgdOGJiSSe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+569Qo7UyU7sffE7SA9kFX7dOF/0r09fe9zpSjLxQnI=;
 b=z2fFOWDdnMQJ3FXdGeDy22yS98Ye7fWluAyo7NPPVLnPC/VF+Hb7iMlnLNprWQRR7SlTjJXrHzr40qYOfTCdb2kJHbPyK5Pp7DF+8W5tihw6ZCeAELp3sflJ5IB13PUtKkoLu++dU6YHi/phzxgxYm8xwMKwMEMhAbpDn3TVRp8=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6827.namprd04.prod.outlook.com (2603:10b6:5:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 21 May
 2025 09:37:53 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 09:37:53 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: "hch@infradead.org" <hch@infradead.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>
Subject: Re: xfs/566 execution time
Thread-Topic: xfs/566 execution time
Thread-Index: AQHbyZC+Gs7KaBMRrE6eXuouWRW7RrPcaz4AgABpqwA=
Date: Wed, 21 May 2025 09:37:53 +0000
Message-ID: <b7vls4sjlx556wax6uagfkey6y5u2t652qu5ne2a6sxpofowdt@3annzxxqdmwq>
References: <aCyM-p06c99rJ04g@infradead.org>
 <20250521031940.GF9730@frogsfrogsfrogs>
In-Reply-To: <20250521031940.GF9730@frogsfrogsfrogs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6827:EE_
x-ms-office365-filtering-correlation-id: 0419fbd7-eabc-4e78-98fc-08dd984b28e8
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LkdgRMV7fnPb9g5vxvMz/ycBHSzDmn2rxDg9YzXTZSy3IunGgOimqU/hy02f?=
 =?us-ascii?Q?MEZJzPkqzHIuaHGpl5UIUhfktFXyjlMiQWdbtolwkBBSnk7yzcQ5SNtJ1FpU?=
 =?us-ascii?Q?/HtbMpX4JLAeXnzNJbrzgKForlvrULyaPJP0uZq52CeaasaqGl6wGF/qXaGl?=
 =?us-ascii?Q?lJ+bXcLRqYc6NKEtKrDgtl7/RkAWTJVAMt4hbdmdWWrptjoyx7v8OoPVTach?=
 =?us-ascii?Q?C2IhmO+L/wZx29vpkN+RHW+yZmg6iNDkoWW7Yok3Opk5Kcgpbt4qRfsgDKmL?=
 =?us-ascii?Q?2k7HhJ/6qO2QjSTczxkTTuJQvgAKAqrpRZGqId4sSDd57+1XtGhaaN+fYiVj?=
 =?us-ascii?Q?E0SFKpty0dVJj0WqMd7UipjnnCPY2L7jk2ga6NypBxfVJM3+eTDDew03BZtA?=
 =?us-ascii?Q?OMZ29juUPlQWqqYUPqj0bHTEstCVx4bI0Au5PHoJ3C8dBhtyse7pxZRunOkS?=
 =?us-ascii?Q?AODzm1hrZSmR52kNM5nNdBXzfmnKNqVKJY+w63C/gZeSqCyq+BS8RqR1Jur6?=
 =?us-ascii?Q?1kiH6IWS7PSJ3aYkX97RPspGp2LrUAwHbGeOHHU39r4mcChx8muuozXwkmqc?=
 =?us-ascii?Q?4ZN/omEhcQ7XaRuJinga77D+vUcocJxFlksZe2+yntVflxX0e+SCOlxGWS4o?=
 =?us-ascii?Q?VNmA0bF2mK3wv+a4ISK1WWmpn7A1vVJW4/sSe3Ry8SbnJZW5VG9GD6DMPP1g?=
 =?us-ascii?Q?RRMf13vXq3niiyXKUYq2jZwfYK7eeUGpXZzK2kSmrmtNHeRnnNvLJAbt7D2V?=
 =?us-ascii?Q?wbrUDWXpFHB5UFDsHCqINJx3TXoDvT7l2O/v8MKQV34L5YFrPhpGc2/7xahn?=
 =?us-ascii?Q?DBlkVvjp3AUIoE02lXBxUpA9RDXhdDbH8SH2AVfqXuhSw2xrYpTge8zcUEI3?=
 =?us-ascii?Q?9caXuuWEISVQGYwVgpYWn/dUFMkFywTpy3mdfnL8Yhv69iH5RuoWAiICT6fE?=
 =?us-ascii?Q?Gp2oc6jNBi0y8GdwDAefs8JG+VQNzvpRJWI5hj3EKLCYPQhc37rjWFOe3u0O?=
 =?us-ascii?Q?G07U8w8bjoJO5wDm6Vnu3XE71rRpG8JWSHvMHlt0fNUaeXqOJsv7Er9p1PKf?=
 =?us-ascii?Q?JhCaH6wSUxjToOPtr1fSqPB+7UE33Dnr3x04WsDKImsVkMk60eTu85X5FYBR?=
 =?us-ascii?Q?/YWQy0TLbTIWBM1sRZYHNzQDqy4Z1xZcrtxuIcq6juG3jth+/2WKjflYz3Oj?=
 =?us-ascii?Q?6IERjz2Q0L6fruony68vWw9SvrqDDFexwcIB4YD2YZRtijkwT83aKbHM0l3m?=
 =?us-ascii?Q?+060pTE6HCsKF2TgkQsxZJG7VisVanfdtdtNsPa9tUOnWDnsgN3+q5FqYBO4?=
 =?us-ascii?Q?CdFigdQeWfq31zRzu7RUpgD/0+lxMi0/YlNMqX4vSzCd3J9hZF6gdzDypbjw?=
 =?us-ascii?Q?mXlTr9sDvLMHO1sbS264W63+HSyKHIylLZ+6b3S2DSPnUSha/bqejD+BiWSs?=
 =?us-ascii?Q?SvGaQZBCzNBbidkoQBxMlawSEDeqQ8tp8vfbMuZ9pWkrhbG/7WJkkswr3CGM?=
 =?us-ascii?Q?Tfz1VTzXjOKf76s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SLj/lIhAa/JzLGdrlYYrfxkEJGkwaVSv5ihzBJWvYegSbk5qJu3QSb7ETkva?=
 =?us-ascii?Q?Zmwj8ZFdYDht0A7nL8qQDFZRzq7H6DmaqOaebPa/B17mDkxQ4wdby5lqDo8N?=
 =?us-ascii?Q?45DV5R/cdNcyGm+TRWzizGi/9RHVBkM4lse0WzdqtOzbxY9ui60rWnLaIcOU?=
 =?us-ascii?Q?IrEMcnxry5gefFG5oULe6V0WlR5EdyAEO46lqj7WNL3/37hURvo2IM+FsclG?=
 =?us-ascii?Q?3VJzpKq4UWQtabSeGP7CpP9Ve9UdfcA+zsV3Cwh7WWvUSb4IyKNorCwHe2g+?=
 =?us-ascii?Q?F/vHBYDroTnOtkKqxVqkKw4iT5pm8bGwzztRkxyonoDW0a+Uu56/kTpKT1r9?=
 =?us-ascii?Q?AtLXAIbZZ+lKQM+2/OnRJqLEOQTlWMbVTxRATVCj8/cm5ke+OZoWreyemvYH?=
 =?us-ascii?Q?J2nr97PFFKvoa+0sleLayls2sYmrP13d4Euci59N199X/Uuyf9RbDAze8Y68?=
 =?us-ascii?Q?SeIxk449EXQVno+yadLqvjuO1JQfE9lI4GfpPn57wiIOVP1DXW5MWkH3faNv?=
 =?us-ascii?Q?4WICMnCreS5YGbmyzDMtwimjtss2BNNIrraitLmjzoTxC3wMOrZnG4lbwzlJ?=
 =?us-ascii?Q?pdvoY/BlsCBbp5qaRa1vGs+yHtGULSUXcinXtbPHcp2jUTWPK2cKZOC0Uv10?=
 =?us-ascii?Q?pK1/1HPhT4GFtz1hFe5F0GdARobW1qwVoDmPk2VBMf9XDJs+WafNC6KNjrZk?=
 =?us-ascii?Q?YTbnc00zsjov3MbugaQyk16Sgv3MaMeVUE+Vmsk7QEG+47JpU4fbwK8SS+x9?=
 =?us-ascii?Q?Zlr1k/3ZFTRD6X+CJHRrwUsR4jgsAhrpuXQAEVHtw8fonS2dIknN1GNcjElK?=
 =?us-ascii?Q?HuTwd4NsJNIqo9En0XpMF286cXaepO8DE8TMAkA4hA7qoN5woq7ZgAViZvF3?=
 =?us-ascii?Q?o+QisAn9vKE8REx0nkpw5d+R4FNvCz1JSr01kWj8YOovpPzfFZQBD8JMWH0l?=
 =?us-ascii?Q?LMaht3h/CbWpk8GPcDgfbKUXFBDFlvOaeyLTa7ow0zpo7qe8/M/cNZYEiIGY?=
 =?us-ascii?Q?MSxT23V9GocKEmcoPaaLDoMIbuhKyS0qUmbakfywU3kVQLwC3H6L0AVH3pA5?=
 =?us-ascii?Q?cSoo+q3Oxj4HTYn8I1GmHI9JBcpCXab7/DK9TNuRM5GtD9Moc8+3jVTcwj+0?=
 =?us-ascii?Q?4zEkjg+tDAdDsb1jW+iakWJX4vDWuxeEQz2M47jWYBHd5StaVX/dIvnny3R7?=
 =?us-ascii?Q?l4hUAOXcbhRivabBZGIZ+UXsBjCthr0PEdGUQYnV+V3/DdojkjWO1UPG34n6?=
 =?us-ascii?Q?YdtnmtTcw3oozn4TF8ejg/Bu1ppopDMQ2uvtVzqTXufSrX6Q0hUvxkFupbCP?=
 =?us-ascii?Q?42HerpU5m5ohnlL3S4SKHuEF0OijgZb4TsHnDrJWeK90w6PYmqqkAeCX3ydz?=
 =?us-ascii?Q?D8lvRc+1ns4DAzgdSfvA1kZYRhW71mdf/cAmZyYVdLcXxjcDwgB8oW+14xPJ?=
 =?us-ascii?Q?67cJW0syRRAYN3wflq5hJmsg71stVbxCPI4Z8R3xUhE/Q8Xse28zZ2w7fvQs?=
 =?us-ascii?Q?woXmlKNRLkc6gJlSo3o27iDqRlj5iaBSes8G8Vh33wumYQ9hYxwr4xlMHO/l?=
 =?us-ascii?Q?GOApy+l0V89TuoW1vtIigyDc0jlRgS6P/FMqu0fvW5sZIVc5IQs/TLO2zM/H?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D55C1A3846A0BA44B5031AB303CB1275@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aPywb2BkWp7JTWHYFFwQcy+t4ANtQZC2nSh/PBFYGOzxYCFt9l+4zrO8FJg9BSk6uYRkblNfURrV+zTe+jkiCRHpV1cqFtxAauazQGdFhDz0cBayxE8rLfPRHN8cCBe9RWtMuN3u+7N+I6A6mmEckvkXdDVMaQWYmcAOh1GkyMlMKARmF8jvMyrlerVYManPh4sZlXusjT6KDi1KQquxq3srVCSAYMWJOO7sTDcsrgHNcFY1NZCy6LfAniCWH4j7wmQd5UdStMrH1fw7n7tNU3+RhjxqzTj/y0n4oLpAhHnpkxGVYgpjK4aBdYUWoBc0SEap4vckHGLmBRr5U+sUT5lNkdurU7bRG81YpTGhJ61uNSPUfgBGF/5FVLT3cZdohV8XW/7g3LiUt335u2tgkCQyrUVi4nYteeKtd1Js8E/D0yrjDj8UDSQdhLlSJxHIETGIhyk+Dqmbf2NdeBkRJADryUC7UHgRVc/XGZbp+qzRr5r4Y1zkEI20YEfaxVNfctk8ezdIAD/u/mCRPW85MXPBiKLjMqx0pZOHxs3cO8ZDlBzQ183zplOGigXbVHAa2JODPplfjEsdt0ye6sCKtqJTwvbfjyqcq024JUPW7n8yWTUFh77K84Pz1uPlT37a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0419fbd7-eabc-4e78-98fc-08dd984b28e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 09:37:53.2154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lymsqiJUqjt8OAf9T7abBYHGAK857VnDl9exsCKsIp+r4v/rLRgRgvKaobr3JMkwQ33W5N0hJFU8DNviutIl2ZG9F6c67QnECFIo1gg2MZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6827

On May 20, 2025 / 20:19, Darrick J. Wong wrote:
> On Tue, May 20, 2025 at 07:08:58AM -0700, Christoph Hellwig wrote:
> > Hi Darrick,
> >=20
> > we regularly see execution times of more than half a day for xfs/566
> > on a 30ish TB SMR HDD.  Do you think there might be a useful way to
> > scale down the load on rotational devices?
>=20
> Hrmm.  Is that the only one that does that, or do the other scrub tests
> take a while too?

As to the test with SMR HDDs, I observed very long test run on two test cas=
es:
xfs/566 and xfs/732.

> If it's just that one, and setting SOAK_DURATION=3D2m
> results in the test cutting off after 2min, then I'll craft some sort of
> fix to constrain the runtime.

I added,

 "export SOAK_DURATION=3D2m"

to local.config and ran xfs/566, but that setting does not look working.
The test case rusn more than a half an hour...=
